<cfsetting showDebugOutput="false">
<cfcontent type="application/json; charset=utf-8">
<cfparam name="url.q" default="">
<cfparam name="url.max" default="8">

<cfset q   = trim(url.q)>
<cfset max = val(url.max)>
<cfif max LTE 0><cfset max = 8></cfif>
<cfif max GT 20><cfset max = 20></cfif>

<!--- Basic response helper --->
<cfset out = { query=q, results=[] }>

<!--- If too short, return empty --->
<cfif len(q) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<!---
  Use Mura/Masa Content Manager public search.
  NOTE: We’ll filter to TITLE ONLY in code below (so you get what you wanted).
--->
<cfset cm = variables.$.getBean("contentManager")>
<cfset it = cm.getPublicSearchIterator( variables.$.event("siteid"), q )>

<cfset count = 0>
<cfloop condition="it.hasNext() AND count LT max">
  <cfset bean = it.next()>

  <!--- Title-only filter: keep only items whose TITLE contains the query --->
  <cfset t = bean.getTitle()>
  <cfif findNoCase(q, t)>
    <cfset arrayAppend(out.results, {
      title = t,
      url   = bean.getURL()
    })>
    <cfset count++>
  </cfif>
</cfloop>

<cfoutput>#serializeJSON(out)#</cfoutput>
