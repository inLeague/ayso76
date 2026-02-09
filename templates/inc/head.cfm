<cfoutput>
<head>

<!-- Force refresh of the page on every load. -->
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<!-- End force refresh on load section -->

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-1812229-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-1812229-2');
</script>
<!-- Begin for the Home Carousel -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/carousel.css" rel="stylesheet">
<!-- End for the Home Carousel -->
<!-- Begin for the Image Lightbox -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/lightbox.css" rel="stylesheet">
<!-- End for the Image Lightbox -->
<!-- Begin for the YouTube Lightbox -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/youtube-lightbox.css" rel="stylesheet">
<!-- End for the YouTube Lightbox -->
<!-- Begin for the Footer Gallery -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/footer_gallery.css" rel="stylesheet">
<!-- End for the Footer Gallery -->
<!-- Begin for the Sportsmanship Cup Popup Message -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/scup-popup.css" rel="stylesheet">
<!-- End for the Sportsmanship Cup Popup Message -->
<!-- Begin for the Age Calculator -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/age-calculator.css" rel="stylesheet">
<!-- End for the Age Calculator -->
<!-- Begin for the Search Box -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/search.css" rel="stylesheet">
<!-- End for the Search Box -->
<!-- Begin for the Tryout Styling CSS -->
    <link href="#m.siteConfig('ThemeAssetPath')#/assets/stylesheets/tryout_styling.css" rel="stylesheet">
<!-- End for the Tryout Styling CSS -->
<link rel="icon" type="image/png" href="#m.siteConfig('ThemeAssetPath')#/images/favicon/favicon-32x32.png" sizes="32x32" />
    <link rel="icon" type="image/png" href="#m.siteConfig('ThemeAssetPath')#/images/favicon/favicon-16x16.png" sizes="16x16" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Fjalla+One|Noto+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="#m.siteConfig('ThemeAssetPath')#/assets/main.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>#m.content('title')#</title>
<!--- =========================
     Open Graph / Twitter Tags
     MASA + CF-friendly snippet
     ========================= --->

<cfscript>
/* ---- Site defaults (edit these) ---- */
siteName        = "AYSO Region 76";
defaultTitle    = "AYSO Region 76 | Beverly Hills Soccer";
defaultDesc     = "AYSO Region 76 youth soccer programs, registration, volunteers, and competitive pathways. Southern California soccer club.";
defaultOgImage  = "https://www.ayso76.org/sites/ayso76/assets/Image/Region%2076%20Images/bh76_logo.png";

/* ---- Resolve page URL safely ---- */
isHttps = (
  structKeyExists(CGI, "HTTPS") AND lcase(CGI.HTTPS) EQ "on"
) OR (
  structKeyExists(CGI, "SERVER_PORT_SECURE") AND val(CGI.SERVER_PORT_SECURE) EQ 1
);
scheme  = isHttps ? "https" : "http";
pageUrl = scheme & "://" & CGI.HTTP_HOST & CGI.SCRIPT_NAME;
if (len(trim(CGI.QUERY_STRING))) {
  pageUrl &= "?" & CGI.QUERY_STRING;
}

/* ---- Pull page-level overrides if defined elsewhere ----
   You can set these per page before the header include:
   request.ogTitle, request.ogDescription, request.ogImage, request.ogUrl
*/
ogTitle = (structKeyExists(request, "ogTitle") AND len(trim(request.ogTitle)))
  ? trim(request.ogTitle)
  : defaultTitle;

ogDesc = (structKeyExists(request, "ogDescription") AND len(trim(request.ogDescription)))
  ? trim(request.ogDescription)
  : defaultDesc;

ogImage = (structKeyExists(request, "ogImage") AND len(trim(request.ogImage)))
  ? trim(request.ogImage)
  : defaultOgImage;

ogUrl = (structKeyExists(request, "ogUrl") AND len(trim(request.ogUrl)))
  ? trim(request.ogUrl)
  : pageUrl;

/* ---- Ensure og:image is absolute ---- */
if (!reFindNoCase("^https?://", ogImage)) {
  if (left(ogImage,1) NEQ "/") ogImage = "/" & ogImage;
  ogImage = scheme & "://" & CGI.HTTP_HOST & ogImage;
}
</cfscript>

<!--- Open Graph --->
<meta property="og:locale" content="en_US">
<meta property="og:type" content="website">
<meta property="og:site_name" content="<cfoutput>#encodeForHTMLAttribute(siteName)#</cfoutput>">
<meta property="og:title" content="<cfoutput>#encodeForHTMLAttribute(ogTitle)#</cfoutput>">
<meta property="og:description" content="<cfoutput>#encodeForHTMLAttribute(ogDesc)#</cfoutput>">
<meta property="og:url" content="<cfoutput>#encodeForHTMLAttribute(ogUrl)#</cfoutput>">
<meta property="og:image" content="<cfoutput>#encodeForHTMLAttribute(ogImage)#</cfoutput>">
<meta property="og:image:secure_url" content="<cfoutput>#encodeForHTMLAttribute(reReplaceNoCase(ogImage,'^http://','https://'))#</cfoutput>">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="<cfoutput>#encodeForHTMLAttribute(ogTitle)#</cfoutput>">

<!--- Twitter --->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="<cfoutput>#encodeForHTMLAttribute(ogTitle)#</cfoutput>">
<meta name="twitter:description" content="<cfoutput>#encodeForHTMLAttribute(ogDesc)#</cfoutput>">
<meta name="twitter:image" content="<cfoutput>#encodeForHTMLAttribute(ogImage)#</cfoutput>">
</head>
</cfoutput>
