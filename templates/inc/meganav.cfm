<cfoutput>

<section class="nav">
    <div class="container-fluid">
        <div class="row">
            <nav class="navbar navbar-expand-lg">
                <div class="col-lg-1 col-md-2 col-sm-12 order-first">
                    <a class="" href="https://#m.siteConfig('domain')#"><img src="#m.siteConfig('ThemeAssetPath')#/images/logo.png" alt="AYSO 76 image" class="img-fluid mx-auto"></a>
                </div>
                <div class="col-lg-1 col-md-2 col-sm-12 order-lg-12">
                    <a class="" href="https://#esapiEncode('html', m.siteConfig('domain'))#"><img src="#m.siteConfig('ThemeAssetPath')#/images/bh-76.png" alt="AYSO 76 image" class="img-fluid align-right"></a>
                </div>
                <button class="navbar-light navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="nav-toggler-title">MENU</span>
                    <span class="navbar-toggler-icon"></span>
                </button>
                    <div class="col-lg-10 col-md-8 col-sm-12 d-none d-sm-block">
                    <div id="navbarNav">
                    <cfinclude template="nav.cfm" />
                    </div>
              </div>
            </nav>
        </div>
    </div>
</section>
</cfoutput>