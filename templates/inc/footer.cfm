<cfoutput>
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-2 col-sm-3">
                <img src="#m.siteConfig('ThemeAssetPath')#/images/footer-logo.png" class="img-fluid mx-auto d-block">
            </div>
            <div class="col-md-2 col-sm-3">
            #m.dspObject(object='component', objectid='Footer AYSO')#
            </div>
            <div class="col-md-4 col-sm-3">
                <div class="footer-cta text-center">
                #m.dspObject(object='component', objectid='Join Board')#
                </div>
            </div>
            <div class="col-md-3 col-sm-3">
            #m.dspObject(object='component', objectid='Colophon')#
            </div>
        </div>
    </div>
<script>
document.addEventListener('DOMContentLoaded', function () {
  const nav = document.querySelector('#navbarMobileNav');
  if (!nav) return;

  // Only activate this on touch devices / mobile
  const isTouchLike = window.matchMedia('(hover: none), (pointer: coarse)').matches;
  if (!isTouchLike) return;

  // Close all other open menus
  function closeOthers(currentLI) {
    nav.querySelectorAll('.nav-list li.open').forEach(li => {
      if (li !== currentLI) {
        li.classList.remove('open');
        const a = li.querySelector(':scope > a[aria-expanded="true"]');
        if (a) a.setAttribute('aria-expanded', 'false');
      }
    });
  }

  // Find parent links that have dropdowns and apply behavior
  nav.querySelectorAll('.nav-list li > a').forEach(link => {
    const submenu = link.nextElementSibling;
    if (!submenu || !submenu.classList.contains('dropdown-menu')) return;

    link.setAttribute('aria-haspopup', 'menu');
    link.setAttribute('aria-expanded', 'false');

    link.addEventListener('click', function (e) {
      const li = link.parentElement;
      const isOpen = li.classList.contains('open');

      if (!isOpen) {
        e.preventDefault(); // first tap = open, do not follow link
        closeOthers(li);
        li.classList.add('open');
        link.setAttribute('aria-expanded', 'true');
      }
      // if already open, second tap will follow the link
    });
  });

  // Optional: tap outside to close menus
  document.addEventListener('click', (evt) => {
    if (!nav.contains(evt.target)) {
      nav.querySelectorAll('.nav-list li.open').forEach(li => {
        li.classList.remove('open');
        const a = li.querySelector(':scope > a[aria-expanded="true"]');
        if (a) a.setAttribute('aria-expanded', 'false');
      });
    }
  });
});
</script>
</footer>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script>
 $('button.navbar-toggler').click(function(){
   $('.wrap-for-mobile-menu').toggleClass('show');
   $('.mobile-collapse').toggleClass('show');
   $('body').toggleClass('absolute-fix');
 });
 $(function($) {
    var widthSize = $( window ).width();
        if (widthSize <= 768) {
          $("li.dropdown-toggle a.nav-link").attr('href', "##");
        }
    });

</script>
</cfoutput>
