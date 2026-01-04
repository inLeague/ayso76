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
  "version" = "r76_search_suggest_JSONONLY_FINAL__hyphenSpaceCompact__prefixFallback",
  "query"   = q,
  "results" = []
}>

<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!--- Helpers: normalize + separator-insensitive matching --->

<cffunction name="r76_norm" access="private" returntype="string" output="false">
  <cfargument name="s" type="string" required="true">
  <cfset var t = lcase(trim(arguments.s))>
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

  <!-- exact-ish token match -->
  <cfif findNoCase(nN, hN) GT 0><cfreturn true></cfif>

  <!-- collapsed match: "move-down" vs "movedown" -->
  <cfif len(nC) GT 0 AND findNoCase(nC, hC) GT 0><cfreturn true></cfif>

  <cfreturn false>
</cffunction>

<cffunction name="r76_alnum" access="private" returntype="string" output="false">
  <cfargument name="s" type="string" required="true">
  <cfset var t = lcase(trim(arguments.s))>
  <cfset t = reReplace(t, "[^a-z0-9]+", "", "all")>
  <cfreturn t>
</cffunction>

<!--- build URL / dedupe by url / separator-insensitive filter (prevents broad noise) --->
<cffunction name="r76_collect" access="private" returntype="numeric" output="false">
  <cfargument name="iterQuery" type="string" required="true">
  <cfargument name="siteID" type="string" required="true">
  <cfargument name="cm" type="any" required="true">
  <cfargument name="qUser" type="string" required="true">
  <cfargument name="max" type="numeric" required="true">
  <cfargument name="seen" type="struct" required="true">
  <cfargument name="out" type="struct" required="true">
  <cfargument name="countIn" type="numeric" required="true">
  <cfargument name="scanLimit" type="numeric" required="true">

  <cfset var it = arguments.cm.getPublicSearchIterator(arguments.siteID, arguments.iterQuery)>
  <cfset var count = arguments.countIn>
  <cfset var scanned = 0>

  <cfset var bean = "">
  <cfset var title = "">
  <cfset var destUrl = "">
  <cfset var urlKey = "">

  <cfloop condition="it.hasNext() AND count LT arguments.max AND scanned LT arguments.scanLimit">
    <cfset scanned = scanned + 1>
    <cfset bean  = it.next()>
    <cfset title = trim(bean.getTitle())>

    <cfif NOT len(title)><cfcontinue></cfif>

    <cfset destUrl = "">
    <cftry>
      <cfset destUrl = variables.$.createHREF(
        contentid = bean.getContentID(),
        siteid    = arguments.siteID
      )>
      <cfcatch>
        <cfset destUrl = "">
      </cfcatch>
    </cftry>

    <cfif NOT len(destUrl)><cfcontinue></cfif>

    <cfif left(destUrl,1) NEQ "/" AND left(destUrl,4) NEQ "http">
      <cfset destUrl = "/" & destUrl>
    </cfif>

    <cfset urlKey = lcase(destUrl)>
    <cfif structKeyExists(arguments.seen, urlKey)><cfcontinue></cfif>

    <!-- separator-insensitive filter (prevents broad wildcard noise) -->
    <cfif NOT r76_contains_sepInsensitive(title, arguments.qUser)><cfcontinue></cfif>

    <cfset arguments.seen[urlKey] = true>
    <cfset arrayAppend(arguments.out.results, { "title" = title, "url" = destUrl })>
    <cfset count = count + 1>
  </cfloop>

  <cfreturn count>
</cffunction>

<cfset siteID = variables.$.event("siteid")>
<cfset cm     = variables.$.getBean("contentManager")>

<cfset seen  = structNew()>
<cfset count = 0>

<!-- Pass 1: exact query -->
<cfset count = r76_collect(q, siteID, cm, q, max, seen, out, count, 200)>

<!-- Pass 2: if still empty/insufficient, do prefix/suffix candidate fetch -->
<cfif count LT max>
  <cfset qA = r76_alnum(q)>

  <!-- Only meaningful when the user typed a single “collapsed” token -->
  <cfset qIsSingle = (find(" ", q) EQ 0 AND find("-", q) EQ 0)>

  <cfif qIsSingle AND len(qA) GTE 4>
    <!-- choose a safe prefix length -->
    <cfset prefLen = 4>
    <cfif len(qA) GTE 10><cfset prefLen = 5></cfif>

    <cfset pref = left(qA, prefLen)>
    <cfset suf  = right(qA, prefLen)>

    <!-- try prefix first (often enough: movedown -> "move") -->
    <cfset count = r76_collect(pref, siteID, cm, q, max, seen, out, count, 300)>

    <!-- if still not enough, try suffix too (movedown -> "down") -->
    <cfif count LT max AND suf NEQ pref>
      <cfset count = r76_collect(suf, siteID, cm, q, max, seen, out, count, 300)>
    </cfif>
  </cfif>
</cfif>

<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
