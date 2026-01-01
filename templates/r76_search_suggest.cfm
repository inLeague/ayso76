<cfsetting enablecfoutputonly="true" showdebugoutput="false">

<!--- Params --->
<cfparam name="url.q"   default="">
<cfparam name="url.max" default="8">
<cfparam name="url.raw" default="1">

<cfset q   = trim(url.q)>
<cfset max = val(url.max)>
<cfif max LTE 0><cfset max = 8></cfif>
<cfif max GT 20><cfset max = 20></cfif>

<!--- Always output clean JSON --->
<cfcontent type="application/json; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfset out = { "query" = q, "results" = [] }>

<!--- Bail early --->
<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!---
  Use Mura/Masa public search iterator (same engine as site search).
  Then return ONLY title + destination URL.
--->
<cfset cm = variables.$.getBean("contentManager")>
<cfset it = cm.getPublicSearchIterator( variables.$.event("siteid"), q )>

<cfset count = 0>

<cfloop condition="it.hasNext() AND count LT max">
  <cfset bean = it.next()>

  <cfset title = trim(bean.getTitle())>

  <!--- Prefer canonical URL methods --->
  <cfset destUrl = "">
  <cftry>
    <!--- Most common --->
    <cfset destUrl = bean.getURL()>
    <cfcatch>
      <cfset destUrl = "">
    </cfcatch>
  </cftry>

  <!--- Fallbacks if getURL() isn't available in your bean --->
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

  <!--- Title-only guard + require a usable URL --->
  <cfif len(title) AND len(destUrl)>
    <!--- Ensure leading slash if it is site-relative --->
    <cfif left(destUrl, 4) NEQ "http" AND left(destUrl, 1) NEQ "/">
      <cfset destUrl = "/" & destUrl>
    </cfif>

    <cfset arrayAppend(out.results, { "title" = title, "url" = destUrl })>
    <cfset count++>
  </cfif>
</cfloop>

<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
