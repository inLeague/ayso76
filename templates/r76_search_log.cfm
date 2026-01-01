<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfcontent type="text/plain; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfparam name="url.d" default="">
<cfset payload = trim(url.d)>

<cfoutput>ok</cfoutput>

<cfif len(payload)>
  <cftry>
    <cfset logPath = expandPath("/sites/ayso76/cache/r76_search_analytics.log")>
    <cflock name="r76SearchAnalyticsLock" type="exclusive" timeout="2">
      <cffile action="append"
              file="#logPath#"
              output="#dateTimeFormat(now(),'yyyy-mm-dd HH:nn:ss')# | #payload##chr(10)#"
              addNewLine="no">
    </cflock>
    <cfcatch></cfcatch>
  </cftry>
</cfif>

<cfabort>
