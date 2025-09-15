<cfoutput>
<!DOCTYPE html>
<html lang="en">
<cfinclude template="inc/head.cfm" />
    <body>
    <cfinclude template="inc/mobilenav.cfm" />
        <cfinclude template="inc/info.cfm" />

        <cfinclude template="inc/meganav.cfm" />

      <section class="banner-img">
            <img src="#m.siteConfig('ThemeAssetPath')#/images/hero-image.jpg" class="full-width-img" alt="AYSO 76">
        </section>
        <section class="entry-wrapper">
          <!--  <div class="container" style="max-width:1600px;">
                <div class="row">-->
                            <h1 id="home_heading" style="text-align:center;">#m.content('title')#</h1>
                            #$.renderEditableAttribute(attribute="body",type="htmlEditor")#
                </div>
            </div>
        </section>
        <cfinclude template="inc/home-footer.cfm" />
        <cfinclude template="inc/footer.cfm" />
    </body>
</html>
</cfoutput>
