<cfsetting enablecfoutputonly="true" showdebugoutput="false">

<!--- Parameters --->
<cfparam name="url.q"   default="">
<cfparam name="url.max" default="8">
<cfparam name="url.raw" default="1">

<cfset q   = trim(url.q)>
<cfset max = val(url.max)>
<cfif max LTE 0><cfset max = 8></cfif>
<cfif max GT 20><cfset max = 20></cfif>

<!--- Force clean JSON output (no theme, no footer, no scripts) --->
<cfcontent type="application/json; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<!--- Base response --->
<cfset out = {
  query   = q,
  results = []
}>

<!--- Bail early if query too short --->
<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!---
  Use MASA / Mura public search engine
  This is the SAME engine your site search page uses
--->
<cfset cm = variables.$.getBean("contentManager")>
<cfset it = cm.getPublicSearchIterator( variables.$.event("siteid"), q )>

<cfset count = 0>

<cfloop condition="it.hasNext() AND count LT max">
  <cfset bean = it.next()>

  <cfset title = trim(bean.getTitle())>
  <cfset url   = bean.getURL()>

  <!--- Title-only match (case-insensitive) --->
  <cfif len(title) AND findNoCase(q, title)>
    <cfset arrayAppend(out.results, {
      title = title,
      url   = url
    })>
    <cfset count++>
  </cfif>
</cfloop>

<!--- Output JSON and STOP --->
<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
