<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfparam name="url.q" default="">
<cfparam name="url.max" default="8">

<cfscript>
qRaw = trim(url.q);
max  = val(url.max);
if (max LTE 0) max = 8;
if (max GT 20) max = 20;

// --- Tuning knobs ---
SCAN_LIMIT  = 500; // max beans scanned across all query variants
SPLIT_LIMIT = 10;  // max split positions attempted for collapsed queries (no spaces/hyphens)

function r76_stripHtml(s){
  s = toString(s);
  // remove tags
  s = reReplace(s, "<[^>]*>", " ", "all");
  // collapse whitespace
  s = reReplace(s, "\s+", " ", "all");
  return trim(s);
}

// separator-insensitive normalization: keep only a-z/0-9
function r76_normSep(s){
  s = lCase(toString(s));
  s = reReplace(s, "[^a-z0-9]+", "", "all");
  return trim(s);
}

function r76_addUnique(arr, seen, v){
  v = trim(toString(v));
  if (!len(v)) return;
  var k = lCase(v);
  if (structKeyExists(seen, k)) return;
  seen[k] = true;
  arrayAppend(arr, v);
}

// Build query variants so collapsed tokens can still find spaced/hyphenated content.
// Example: movedown -> move down / move-down (via generic splits)
function r76_buildVariants(q){
  var base = trim(toString(q));
  var out  = [];
  var seen = structNew();
  if (!len(base)) return out;

  r76_addUnique(out, seen, base);

  // If query contains hyphens, also try spaced + compact
  if (find("-", base)){
    r76_addUnique(out, seen, reReplace(base, "-+", " ", "all"));
    r76_addUnique(out, seen, reReplace(base, "-+", "",  "all"));
  }

  // If query contains spaces, also try hyphen + compact
  if (reFind("\s", base)){
    r76_addUnique(out, seen, reReplace(base, "\s+", "-", "all"));
    r76_addUnique(out, seen, reReplace(base, "\s+", "",  "all"));
  }

  // If query has NO separators, try generic splits: abcdef -> abc def / abc-def (etc)
  // This is what fixes movedown -> move down, allstar -> all star, etc (without a map).
  if (!find("-", base) && !reFind("\s", base) && len(base) GTE 6){
    var L = len(base);
    var startPos = 3;
    var endPos   = L - 3;
    var splitsTried = 0;

    for (var p = startPos; p LTE endPos; p++){
      if (splitsTried GTE SPLIT_LIMIT) break;

      var leftPart  = left(base, p);
      var rightPart = mid(base, p+1, L-p);

      // Avoid silly splits where one side is tiny after trimming
      if (len(leftPart) GTE 3 && len(rightPart) GTE 3){
        r76_addUnique(out, seen, leftPart & " " & rightPart);
        r76_addUnique(out, seen, leftPart & "-" & rightPart);
        splitsTried++;
      }
    }
  }

  return out;
}
</cfscript>

<cfcontent type="application/json; charset=utf-8" reset="true">
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate, max-age=0">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfset out = {
  "version" = "r76_search_suggest_JSONONLY_FINAL__titleAndContent__sepInsensitive",
  "query"   = qRaw,
  "results" = []
}>

<cfif len(qRaw) LT 2>
  <cfoutput>#serializeJSON(out)#</cfoutput>
  <cfabort>
</cfif>

<cfset siteID = variables.$.event("siteid")>
<cfset cm = variables.$.getBean("contentManager")>

<cfset targetKey = r76_normSep(qRaw)>
<cfset variants  = r76_buildVariants(qRaw)>

<cfset seenUrl = structNew()>
<cfset count = 0>
<cfset scanned = 0>

<cfloop array="#variants#" index="qTry">
  <cfif count GTE max OR scanned GTE SCAN_LIMIT>
    <cfbreak>
  </cfif>

  <cfset it = cm.getPublicSearchIterator(siteID, qTry)>

  <cfloop condition="it.hasNext() AND count LT max AND scanned LT SCAN_LIMIT">
    <cfset bean = it.next()>
    <cfset scanned = scanned + 1>

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
    <cfset urlKey = lCase(destUrl)>
    <cfif structKeyExists(seenUrl, urlKey)>
      <cfcontinue>
    </cfif>

    <!--- separator-insensitive filter (prevents broad wildcard noise)
         IMPORTANT: apply filter to TITLE + SUMMARY + BODY so content-only hits survive
    --->
    <cfset summaryTxt = "">
    <cfset bodyTxt    = "">
    <cftry><cfset summaryTxt = toString(bean.getValue("summary",""))><cfcatch></cfcatch></cftry>
    <cftry><cfset bodyTxt    = toString(bean.getValue("body",""))><cfcatch></cfcatch></cftry>
    <cftry><cfset bodyTxt    = bodyTxt & " " & toString(bean.getValue("body2",""))><cfcatch></cfcatch></cftry>

    <cfset hay = r76_stripHtml(title & " " & summaryTxt & " " & bodyTxt)>
    <cfset hayKey = r76_normSep(hay)>

    <cfif NOT len(hayKey) OR hayKey DOES NOT CONTAIN targetKey>
      <cfcontinue>
    </cfif>

    <cfset seenUrl[urlKey] = true>
    <cfset arrayAppend(out.results, { "title" = title, "url" = destUrl })>
    <cfset count = count + 1>
  </cfloop>
</cfloop>

<cfoutput>#serializeJSON(out)#</cfoutput>
<cfabort>
