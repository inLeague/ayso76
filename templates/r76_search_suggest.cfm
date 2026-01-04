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

<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!--- =========================================================
      Get public search iterator
      NOTE: This endpoint MUST output JSON ONLY (no HTML comments)
      so the JS can parse it (it expects response to start with "{")
========================================================= --->
<cfset siteID = variables.$.event("siteid")>
<cfset cm     = variables.$.getBean("contentManager")>
<cfset it     = cm.getPublicSearchIterator(siteID, q)>

<!--- =========================================================
      Helpers: normalize + separator-insensitive matching
      (treat hyphen/space/punctuation as equivalent)
========================================================= --->
<cffunction name="r76_norm" access="private" returntype="string" output="false">
  <cfargument name="s" type="string" required="true">
  <cfset var t = lcase(trim(arguments.s))>
  <!--- convert any non [a-z0-9] to spaces, then collapse spaces --->
  <cfset t = reReplace(t, "[^a-z0-9]+", " ", "all")>
  <cfset t = reReplace(t, "\s+", " ", "all")>
  <cfreturn t>
</cffunction>

<cffunction name="r76_compact" access="private" returntype="string" output="false">
  <cfargument name="s" type="string" required="true">
  <cfset var t = r76_norm(arguments.s)>
  <cfset t = replace(t, " ", "", "all")>
  <cfreturn t>
</cffunction>

<cffunction name="r76_contains_sepInsensitive" access="private" returntype="boolean" output="false">
  <cfargument name="hay" type="string" required="true">
  <cfargument name="needle" type="string" required="true">

  <cfset var hN = r76_norm(arguments.hay)>
  <cfset var nN = r76_norm(arguments.needle)>
  <cfset var hC = r76_compact(arguments.hay)>
  <cfset var nC = r76_compact(arguments.needle)>

  <cfif len(nN) EQ 0><cfreturn false></cfif>

  <!--- normal contains (space-insensitive-ish) --->
  <cfif findNoCase(nN, hN) GT 0><cfreturn true></cfif>

  <!--- compact contains (hyphen/space/punct ignored) --->
  <cfif len(nC) GT 0 AND findNoCase(nC, hC) GT 0><cfreturn true></cfif>

  <cfreturn false>
</cffunction>

<!--- =========================================================
      Build results (dedupe by URL)
      Include title + computed href
      Apply separator-insensitive filter to reduce wildcard noise
========================================================= --->
<cfset seen = structNew()>
<cfset count = 0>

<cfloop condition="it.hasNext() AND count LT max">
  <cfset bean  = it.next()>
  <cfset title = trim(bean.getTitle())>

  <cfif NOT len(title)>
    <cfcontinue>
  </cfif>

  <!--- build URL --->
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

  <cfif NOT len(destUrl)>
    <cfcontinue>
  </cfif>

  <cfif left(destUrl,1) NEQ "/" AND left(destUrl,4) NEQ "http">
    <cfset destUrl = "/" & destUrl>
  </cfif>

  <!--- dedupe by url --->
  <cfset urlKey = lcase(destUrl)>
  <cfif structKeyExists(seen, urlKey)>
    <cfcontinue>
  </cfif>
  <cfset seen[urlKey] = true>

  <!--- separator-insensitive filter (prevents broad wildcard noise) --->
  <!--- Only keep if the TITLE matches query in a separator-insensitive way --->
  <cfif NOT r76_contains_sepInsensitive(title, q)>
    <cfcontinue>
  </cfif>

  <cfset arrayAppend(out.results, { "title" = title, "url" = destUrl })>
  <cfset count = count + 1>
</cfloop>

<!--- JSON ONLY output (no HTML comments above this point) --->
<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
