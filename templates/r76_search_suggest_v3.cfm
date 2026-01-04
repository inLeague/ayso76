<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfparam name="url.q" default="">
<cfparam name="url.max" default="8">

<cfset q   = trim(url.q)>
<cfset max = val(url.max)>
<cfif max LTE 0><cfset max = 8></cfif>
<cfif max GT 20><cfset max = 20></cfif>

<cfcontent type="application/json; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfset out = {
  "version" = "r76_search_suggest_JSONONLY_FINAL__hyphenSpaceCompact",
  "query"   = q,
  "results" = []
}>

<cfset out.debug = {
  "siteID" = siteID,
  "qLen"   = len(q),
  "max"    = max
}>

<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!---
  =========================================================
  Separator-insensitive matching helpers
  - normalizeForCompare: lowercases + turns punctuation/hyphens into spaces
  - collapseForCompare: removes spaces entirely ("move-down" -> "movedown")
  =========================================================
--->
<cffunction name="normalizeForCompare" access="private" returntype="string" output="false">
  <cfargument name="s" type="string" required="true">
  <cfset var t = lcase(trim(arguments.s))>
  <!-- replace any non-alphanumeric with space -->
  <cfset t = reReplace(t, "[^a-z0-9]+", " ", "all")>
  <!-- collapse whitespace -->
  <cfset t = reReplace(t, "\s+", " ", "all")>
  <cfreturn trim(t)>
</cffunction>

<cffunction name="collapseForCompare" access="private" returntype="string" output="false">
  <cfargument name="norm" type="string" required="true">
  <cfreturn replace(arguments.norm, " ", "", "all")>
</cffunction>

<!--- Normalize the USER query once (this is what we match against) --->
<cfset qNorm    = normalizeForCompare(q)>
<cfset qCompact = collapseForCompare(qNorm)>

<!---
  =========================================================
  Build backend query variants (generic, no compound map)
  We ask Mura for results using a few forms:
  - original query
  - hyphen -> space
  - space -> hyphen
  - compact (remove spaces & hyphens)
  - OPTIONAL: wildcard fanout for single-token queries (best-effort)
  =========================================================
--->
<cfset variants = []>

<cfset qNoHyphen = replace(q, "-", "", "all")>
<cfset qNoSpace  = replace(q, " ", "", "all")>
<cfset qCompactRaw = replace(qNoHyphen, " ", "", "all")>

<cfset arrayAppend(variants, q)>
<cfset arrayAppend(variants, replace(q, "-", " ", "all"))>
<cfset arrayAppend(variants, replace(q, " ", "-", "all"))>
<cfset arrayAppend(variants, qCompactRaw)>

<!---
  OPTIONAL wildcard variant:
  - Helps cases like "movedown" matching "move-down" when the backend only tokenizes on separators
  - This relies on the underlying search supporting wildcards.
  - Keep it bounded: only for single-token-ish queries of reasonable length.
--->
<cfif (find(" ", q) EQ 0) AND (find("-", q) EQ 0) AND (len(q) GTE 4) AND (len(q) LTE 20)>
  <cfset qStar = "">
  <cfloop from="1" to="#len(q)#" index="i">
    <cfset qStar &= mid(q, i, 1) & "*">
  </cfloop>
  <cfset arrayAppend(variants, qStar)>
</cfif>

<!--- De-dupe variants case-insensitively and remove blanks --->
<cfset seenVar = {}> <!--- struct of lowercased variant -> true --->
<cfset cleanVariants = []>
<cfloop array="#variants#" index="v">
  <cfset v = trim(v)>
  <cfif NOT len(v)><cfcontinue></cfif>
  <cfset vKey = lcase(v)>
  <cfif structKeyExists(seenVar, vKey)><cfcontinue></cfif>
  <cfset seenVar[vKey] = true>
  <cfset arrayAppend(cleanVariants, v)>
</cfloop>

<!--- Get siteID reliably (endpoints often don't have event('siteid')) --->
<cfset siteID = "">

<cftry>
  <cfset siteID = trim(variables.$.event("siteid"))>
  <cfcatch>
    <cfset siteID = "">
  </cfcatch>
</cftry>

<!--- Optional: allow ?siteid=default override --->
<cfparam name="url.siteid" default="">
<cfif NOT len(siteID) AND len(trim(url.siteid))>
  <cfset siteID = trim(url.siteid)>
</cfif>

<!--- Final fallback --->
<cfif NOT len(siteID)>
  <cfset siteID = "default">
</cfif>
<cfset cm = variables.$.getBean("contentManager")>

<!--- Dedupe final results by URL --->
<cfset seenUrl = {}>

<!--- Hard safety cap so we don't iterate forever across variants --->
<cfset count = 0>
<cfset perVariantScanCap = 120>

<!---
  =========================================================
  Fetch + merge + filter
  Filtering logic (key part):
    Keep result if:
      normalize(title) contains normalize(query)
      OR
      collapse(normalize(title)) contains collapse(normalize(query))
  This makes:
    movedown  match  move-down
    post season match post-season
    etc.
  =========================================================
--->
<cfloop array="#cleanVariants#" index="vq">
  <cfif count GTE max><cfbreak></cfif>

  <cfset it = cm.getPublicSearchIterator(siteID, vq)>
  <cfset scanned = 0>

  <cfloop condition="it.hasNext() AND count LT max">
    <cfset scanned++>
    <cfif scanned GT perVariantScanCap><cfbreak></cfif>

    <cfset bean = it.next()>
    <cfset title = trim(bean.getTitle())>
    <cfif NOT len(title)><cfcontinue></cfif>

    <!-- build URL -->
    <cfset destUrl = "">
    <cftry>
      <cfset destUrl = variables.$.createHREF(
        contentid = bean.getContentID(),
        siteid    = siteID
      )>
      <cfcatch>
        <cfset destUrl = "">
      </cfcatch>
    </cftry>
    <cfif NOT len(destUrl)><cfcontinue></cfif>

    <cfif left(destUrl,1) NEQ "/" AND left(destUrl,4) NEQ "http">
      <cfset destUrl = "/" & destUrl>
    </cfif>

    <!-- dedupe by url -->
    <cfif structKeyExists(seenUrl, destUrl)><cfcontinue></cfif>

    <!-- separator-insensitive filter (prevents broad wildcard noise) -->
    <cfset tNorm    = normalizeForCompare(title)>
    <cfset tCompact = collapseForCompare(tNorm)>

    <cfif (findNoCase(qNorm, tNorm) EQ 0) AND (findNoCase(qCompact, tCompact) EQ 0)>
      <cfcontinue>
    </cfif>

    <cfset seenUrl[destUrl] = true>
    <cfset arrayAppend(out.results, { "title" = title, "url" = destUrl })>
    <cfset count++>
  </cfloop>
</cfloop>

<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
