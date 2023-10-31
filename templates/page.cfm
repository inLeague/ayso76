<cfoutput>
<!DOCTYPE html>
<html lang="en">
<cfinclude template="inc/head.cfm" />
<body class="internal-template">

   <cfinclude template="inc/mobilenav.cfm" />
         <cfinclude template="inc/info.cfm" />

   <cfinclude template="inc/meganav.cfm" />
<section class="internal-banner">
    <div class="container">
        <div class="row justify-content-center text-center">
            <div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-12">
                <h1>#m.content('title')#</h1>
                #m.renderEditableAttribute(attribute="summary",type="htmlEditor")#
            </div>
        </div>
    </div>
</section>
<section class="internal-entry">
    <div class="container">
        <div class="row">
            <div class="col-12">
                #$.dspBody(
                                    body=$.content('body')
                                    , crumbList=false
                                    , showMetaImage=false
                                    )#
            </div>
        </div>
    </div>

</section>
<cfinclude template="inc/footer.cfm" />
<!-- Begin Constant Contact Active Forms -->
<script> var _ctct_m = "5311d8bb7b81cf49a91ff666f7438063"; </script>
<script id="signupScript" src="//static.ctctcdn.com/js/signup-form-widget/current/signup-form-widget.min.js" async defer></script>
<!-- End Constant Contact Active Forms -->
</body>
</html>
</cfoutput>
