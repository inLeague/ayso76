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
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-12 col-sm-12">
                        <div class="entry">
                            <h1 style="text-align:center;">#m.content('title')#</h1>
                            #$.renderEditableAttribute(attribute="body",type="htmlEditor")#
                        </div>
                    </div>
<!--                    <div class="col-lg-5 col-md-12 col-sm-12">
                        #m.dspObject(object='component', objectid='Home Quick Links')#
                        #m.dspObject(object='component', objectid='Medical Form Release')#
                        <div class="vip-program">
                            #m.dspObject(object='component', objectid='VIP')#
                        </div>
                    </div>-->
                </div>
            </div>
        </section>
        <cfinclude template="inc/home-footer.cfm" />
        <cfinclude template="inc/footer.cfm" />
    </body>
</html>
</cfoutput>
