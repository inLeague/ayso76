<cfsetting enablecfoutputonly="true" showdebugoutput="false">

<!-- ======================================================
     PARAMETERS
====================================================== -->
<cfparam name="url.q"   default="">
<cfparam name="url.max" default="8">
<cfparam name="url.raw" default="1">

<cfset q   = trim(url.q)>
<cfset max = val(url.max)>

<cfif max LTE 0>
  <cfset max = 8>
</cfif>
<cfif max GT 20>
  <cfset max = 20>
</cfif>

<!-- ======================================================
     FORCE CLEAN JSON RESPONSE (NO THEME / FOOTER)
====================================================== -->
<cfcontent type="application/json; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<!-- ======================================================
     RESPONSE STRUCTURE
     (version helps confirm the correct file is executing)
====================================================== -->
<cfset out = {
  "version" = "r76_search_suggest_FINAL_2026-01-01",
  "query"   = q,
  "results" = []
}>

<!-- ======================================================
     EARLY EXIT
====================================================== -->
<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!-- ======================================================
     SEARCH (PUBLIC SEARCH ITERATOR)
     SAME ENGINE AS SITE SEARCH
====================================================== -->
<cfset siteID = variables.$.event("siteid")>
<cfset cm     = variables.$.getBean("contentManager")>
<cfset it     = cm.getPublicSearchIterator(siteID, q)>

<cfset count = 0>

<cfloop condition="it.hasNext() AND count LT max">

  <cfset bean = it.next()>

  <!-- ---------- TITLE ---------- -->
  <cfset title = trim(bean.getTitle())>
  <cfif NOT len(title)>
    <cfcontinue>
  </cfif>

  <!-- ---------- DESTINATION URL (CANONICAL) ---------- -->
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

  <!-- ---------- VALIDATE ---------- -->
  <cfif NOT len(destUrl)>
    <cfcontinue>
  </cfif>

  <!-- Ensure site-relative paths are normalized -->
  <cfif left(destUrl,4) NEQ "http" AND left(destUrl,1) NEQ "/">
    <cfset destUrl = "/" & destUrl>
  </cfif>

  <!-- ---------- ADD RESULT ---------- -->
  <cfset arrayAppend(
    out.results,
    {
      "title" = title,
      "url"   = destUrl
    }
  )>

  <cfset count++>

</cfloop>

<!-- ======================================================
     OUTPUT + HARD STOP
====================================================== -->
<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
