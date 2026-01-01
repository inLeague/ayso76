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
     BASE RESPONSE STRUCTURE
====================================================== -->
<cfset out = {
  "query"   = q,
  "results" = []
}>

<!-- ======================================================
     EARLY EXIT FOR SHORT QUERIES
====================================================== -->
<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!-- ======================================================
     RUN MASA / MURA PUBLIC SEARCH
     (same engine as /search page)
====================================================== -->
<cfset cm = variables.$.getBean("contentManager")>
<cfset it = cm.getPublicSearchIterator( variables.$.event("siteid"), q )>

<cfset count = 0>

<cfloop condition="it.hasNext() AND count LT max">

  <cfset bean = it.next()>

  <!-- ---------- TITLE ---------- -->
  <cfset title = trim(bean.getTitle())>

  <!-- ---------- DESTINATION URL ---------- -->
  <cfset destUrl = "">

  <!-- Preferred canonical URL -->
  <cftry>
    <cfset destUrl = bean.getURL()>
    <cfcatch>
      <cfset destUrl = "">
    </cfcatch>
  </cftry>

  <!-- Fallbacks for older / custom beans -->
  <cfif NOT len(destUrl)>
    <cftry>
      <cfset destUrl = bean.get("url")>
      <cfcatch><cfset destUrl = ""></cfcatch>
    </cftry>
  </cfif>

  <cfif NOT len(destUrl)>
    <cftry>
      <cfset destUrl = bean.get("filename")>
      <cfcatch><cfset destUrl = ""></cfcatch>
    </cftry>
  </cfif>

  <!-- ---------- VALIDATE + NORMALIZE ---------- -->
  <cfif len(title) AND len(destUrl)>

    <!-- Ensure site-relative URLs start with / -->
    <cfif left(destUrl, 4) NEQ "http" AND left(destUrl, 1) NEQ "/">
      <cfset destUrl = "/" & destUrl>
    </cfif>

    <!-- Push clean result -->
    <cfset arrayAppend(
      out.results,
      {
        "title" = title,
        "url"   = destUrl
      }
    )>

    <cfset count++>

  </cfif>

</cfloop>

<!-- ======================================================
     OUTPUT + HARD STOP
====================================================== -->
<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
