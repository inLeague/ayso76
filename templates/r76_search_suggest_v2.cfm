<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfparam name="url.q" default="">
<cfparam name="url.max" default="8">

<cfset q = trim(url.q)>
<cfset max = val(url.max)>
<cfif max LTE 0><cfset max = 8></cfif>
<cfif max GT 20><cfset max = 20></cfif>

<cfcontent type="application/json; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfset out = {
  "version" = "r76_search_suggest_JSONONLY_FINAL",
  "query"   = q,
  "results" = []
}>

<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<cfset siteID = variables.$.event("siteid")>
<cfset cm = variables.$.getBean("contentManager")>
<cfset it = cm.getPublicSearchIterator(siteID, q)>
<cfset count = 0>

<cfloop condition="it.hasNext() AND count LT max">
  <cfset bean = it.next()>
  <cfset title = trim(bean.getTitle())>

  <cfif NOT len(title)>
    <cfcontinue>
  </cfif>

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

  <cfset arrayAppend(out.results, { "title" = title, "url" = destUrl })>
  <cfset count++>
</cfloop>

<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
