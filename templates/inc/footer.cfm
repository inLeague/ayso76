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
</footer>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>

<!-- Begin Constant Contact Active Forms -->
<script> var _ctct_m = "5311d8bb7b81cf49a91ff666f7438063"; </script>
<script id="signupScript" src="//static.ctctcdn.com/js/signup-form-widget/current/signup-form-widget.min.js" async defer></script>
<!-- End Constant Contact Active Forms -->

<script>
 $('button.navbar-toggler').click(function(){
   $('.wrap-for-mobile-menu').toggleClass('show');
   $('.mobile-collapse').toggleClass('show');
   $('body').toggleClass('absolute-fix');
 });

/* --- Mobile dropdown behavior: 1st click opens, 2nd click follows link --- */
/* Works on touch and desktop when in mobile layout */
/* CF-safe: doubled ## in selectors inside strings */

document.addEventListener('DOMContentLoaded', function () {
  var nav = document.querySelector('##navbarMobileNav');
  if (!nav) return;

  // Treat it as "mobile mode" when either:
  //  - touch device, OR
  //  - viewport <= 900px, OR
  //  - your mobile menu is visibly open
  var mqMobileWidth = window.matchMedia('(max-width: 900px)');
  function isMobileMenuActive() {
    return (
      window.matchMedia('(hover: none), (pointer: coarse)').matches ||
      mqMobileWidth.matches ||
      document.body.classList.contains('absolute-fix') ||
      document.querySelector('.wrap-for-mobile-menu.show') ||
      document.querySelector('.mobile-collapse.show')
    );
  }

  // Close all other open dropdowns
  function closeOthers(currentLI) {
    nav.querySelectorAll('.nav-list li.open').forEach(function (li) {
      if (li !== currentLI) {
        li.classList.remove('open');
        var a = li.querySelector(':scope > a[aria-expanded="true"]');
        if (a) a.setAttribute('aria-expanded', 'false');
        if (a && a.dataset) delete a.dataset.firstTap;
      }
    });
  }

  // Enable first-click open / second-click navigate
  Array.prototype.slice.call(nav.querySelectorAll('.nav-list li > a')).forEach(function (link) {
    var submenu = link.nextElementSibling;
    if (!submenu || !submenu.classList.contains('dropdown-menu')) return;

    // mark for caret
    link.parentElement.classList.add('has-sub');
    link.setAttribute('aria-haspopup', 'menu');
    link.setAttribute('aria-expanded', 'false');

    link.addEventListener('click', function (e) {
      if (!isMobileMenuActive()) return; // desktop full nav: do nothing special

      var li = link.parentElement;
      var isOpen = li.classList.contains('open');
      var firstTapDone = link.dataset.firstTap === '1';

      // FIRST CLICK — open menu
      if (!isOpen) {
        e.preventDefault();
        closeOthers(li);
        li.classList.add('open');
        link.setAttribute('aria-expanded', 'true');
        link.dataset.firstTap = '1';
        return;
      }

      // IF OPEN BUT firstTap wasn't marked, treat as first click
      if (!firstTapDone) {
        e.preventDefault();
        link.dataset.firstTap = '1';
        return;
      }

      // SECOND CLICK — NAVIGATE
      e.preventDefault();
      delete link.dataset.firstTap;
      link.setAttribute('aria-expanded', 'false');
      li.classList.remove('open');
      window.location.href = link.href;
    });
  });

  // Close menus when clicking outside
  document.addEventListener('click', function (evt) {
    if (!nav.contains(evt.target)) {
      nav.querySelectorAll('.nav-list li.open').forEach(function (li) {
        li.classList.remove('open');
        var a = li.querySelector(':scope > a[aria-expanded="true"]');
        if (a) a.setAttribute('aria-expanded', 'false');
        if (a && a.dataset) delete a.dataset.firstTap;
      });
    }
  }, { passive: true });

  // If screen resizes across breakpoint, reset menu
  mqMobileWidth.addEventListener('change', function () {
    nav.querySelectorAll('.nav-list li.open').forEach(function (li) {
      li.classList.remove('open');
      var a = li.querySelector(':scope > a[aria-expanded="true"]');
      if (a) a.setAttribute('aria-expanded', 'false');
      if (a && a.dataset) delete a.dataset.firstTap;
    });
  });
});
</script>

<style>
/* Show/animate carets when:
   - device is touch/coarse, OR
   - viewport is narrow (<=900px) so desktop acts like mobile */
@media (hover: none), (pointer: coarse), (max-width: 900px) {
  ##navbarMobileNav .nav-list li.has-sub > a {
    position: relative;
    padding-right: 1.25rem; /* room for caret */
  }
  ##navbarMobileNav .nav-list li.has-sub > a::after {
    content: "";
    position: absolute;
    right: 0.35rem;
    top: 50%;
    transform: translateY(-50%) rotate(0deg);
    transition: transform 200ms ease;
    width: 0; height: 0;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-top: 6px solid currentColor; /* small down arrow */
    pointer-events: none; /* clicks go to the link */
  }
  ##navbarMobileNav .nav-list li.open > a::after {
    transform: translateY(-50%) rotate(180deg);
  }
  .dropdown-toggle::after { display: none; }
}
</style>
</cfoutput>
<script>
(function () {
  // ====== CONFIG (CF-safe) ======
  const NAV_ROOT_ID   = 'navbarMobileNav';
  const TOGGLE_CLASS  = 'dropdown-toggle';
  const MENU_CLASS    = 'dropdown-menu';
  const LINK_SELECTOR = 'a';
  const MOBILE_MAX_WIDTH = 767;
  const DELAY_MS = 450;                 // guard delay after opening/closing
  const TOUCH_SLOP = 12;                // px movement allowed to still count as a "tap"
  const ROOT_GUARD_CLASS = 'tap-guard-active';

  // ====== STATE ======
  let guardUntil = 0;
  let openToggle = null;

  // Track a single active pointer to disambiguate drag vs tap
  let activePointerId = null;
  let downX = 0, downY = 0;
  let moved = false;
  let downTarget = null;

  const now = () => performance.now();
  const isMobile = () => window.innerWidth <= MOBILE_MAX_WIDTH;
  const inGuard  = () => isMobile() && now() < guardUntil;
  const navRoot  = () => document.getElementById(NAV_ROOT_ID);

  function startGuard() {
    if (!isMobile()) return;
    guardUntil = now() + DELAY_MS;
    const root = navRoot();
    if (root) root.classList.add(ROOT_GUARD_CLASS);
    clearTimeout(startGuard._t);
    startGuard._t = setTimeout(() => {
      const r = navRoot();
      if (r) r.classList.remove(ROOT_GUARD_CLASS);
    }, DELAY_MS + 20);
  }

  function findMenu(toggleEl) {
    if (!toggleEl) return null;
    const scope = toggleEl.closest('li, .nav-item, .dropdown') || toggleEl;
    return scope ? scope.querySelector('.' + MENU_CLASS) : null;
  }

  // --- Anim helpers ---
  function prepMenuForAnimation(menu) {
    menu.style.overflow = 'hidden';
    menu.style.willChange = 'height, opacity, transform';
    menu.style.transition = 'height 220ms ease, opacity 180ms ease, transform 180ms ease';
    menu.style.transformOrigin = 'top';
  }

  function openMenu(toggleEl) {
    const menu = findMenu(toggleEl);
    if (!menu) return;

    closeAllMenus(toggleEl);
    prepMenuForAnimation(menu);

    menu.style.display   = 'block';
    menu.style.height    = '0px';
    menu.style.opacity   = '0';
    menu.style.transform = 'translateY(-4px)';

    const targetHeight = menu.scrollHeight;

    requestAnimationFrame(() => {
      toggleEl.setAttribute('aria-expanded', 'true');
      toggleEl.classList.add('is-open');
      menu.classList.add('show');
      menu.style.height    = targetHeight + 'px';
      menu.style.opacity   = '1';
      menu.style.transform = 'translateY(0)';
    });

    const done = (e) => {
      if (e.propertyName !== 'height') return;
      menu.style.height = 'auto';
      menu.removeEventListener('transitionend', done);
    };
    menu.addEventListener('transitionend', done);

    openToggle = toggleEl;
  }

  function closeMenu(toggleEl) {
    const menu = findMenu(toggleEl);
    if (!menu) return;

    prepMenuForAnimation(menu);
    menu.style.height    = menu.scrollHeight + 'px';
    menu.style.opacity   = '1';
    menu.style.transform = 'translateY(0)';
    menu.offsetHeight; // reflow

    requestAnimationFrame(() => {
      menu.style.height    = '0px';
      menu.style.opacity   = '0';
      menu.style.transform = 'translateY(-4px)';
      toggleEl.setAttribute('aria-expanded', 'false');
      toggleEl.classList.remove('is-open');
      menu.classList.remove('show');
    });

    const done = (e) => {
      if (e.propertyName !== 'height') return;
      menu.style.display    = 'none';
      menu.style.transition = '';
      menu.style.height     = '';
      menu.style.opacity    = '';
      menu.style.transform  = '';
      menu.style.overflow   = '';
      menu.style.willChange = '';
      menu.removeEventListener('transitionend', done);
    };
    menu.addEventListener('transitionend', done);

    if (openToggle === toggleEl) openToggle = null;
  }

  function closeAllMenus(exceptToggle) {
    const root = navRoot();
    if (!root) return;
    root.querySelectorAll('.' + TOGGLE_CLASS + '.is-open').forEach(t => {
      if (t !== exceptToggle) closeMenu(t);
    });
  }

  function isInside(el, container) { return !!(el && container && container.contains(el)); }
  function getToggleFromTarget(target) { return target.closest('.' + TOGGLE_CLASS); }
  function getMenuLinkFromTarget(target) {
    const link = target.closest(LINK_SELECTOR);
    if (!link) return null;
    return link.closest('.' + MENU_CLASS) ? link : null;
  }

  // ====== TAP / DRAG DETECTION ======
  function onPointerDownStart(e) {
    if (!isMobile()) return;
    const root = navRoot();
    if (!root || !isInside(e.target, root)) return;

    // If another pointer is active, ignore extras
    if (activePointerId !== null) return;

    activePointerId = e.pointerId;
    downX = e.clientX;
    downY = e.clientY;
    moved = false;
    downTarget = e.target;
    // Do NOT preventDefault here — we want natural scrolling.
  }

  function onPointerMoveTrack(e) {
    if (!isMobile()) return;
    if (activePointerId === null || e.pointerId !== activePointerId) return;

    if (!moved) {
      const dx = Math.abs(e.clientX - downX);
      const dy = Math.abs(e.clientY - downY);
      if (dx > TOUCH_SLOP || dy > TOUCH_SLOP) {
        moved = true; // This interaction is a scroll/drag, not a tap.
      }
    }
  }

  function onPointerUpWithinNav(e) {
    if (!isMobile()) return;
    if (activePointerId === null || e.pointerId !== activePointerId) return;

    const root = navRoot();
    const upTarget = e.target;

    // Reset pointer tracking ASAP
    activePointerId = null;

    // If user dragged/scrolled, do nothing.
    if (moved) return;

    // Treat as a TAP if the up occurs inside the nav
    if (!root || !isInside(upTarget, root)) return;

    const clickedToggle   = getToggleFromTarget(upTarget);
    const clickedMenuLink = getMenuLinkFromTarget(upTarget);

    // Tapped a dropdown toggle
    if (clickedToggle) {
      if (inGuard() && clickedToggle !== openToggle) {
        e.preventDefault(); e.stopPropagation(); return;
      }
      const isOpen = clickedToggle.classList.contains('is-open');

      if (!isOpen) {
        // Open this menu
        e.preventDefault(); e.stopPropagation();
        openMenu(clickedToggle);
        startGuard();
        return;
      } else {
        // If still within guard, swallow the second tap
        if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
        // Otherwise let the browser follow its default (which might be navigating if it's also a link)
      }
    }

    // Tapped a link inside an open menu
    if (clickedMenuLink) {
      if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
      // Close menus when navigating away
      closeAllMenus();
      // Allow navigation to proceed naturally (no preventDefault)
    }
  }

  function onPointerCancel(e) {
    if (!isMobile()) return;
    if (e.pointerId === activePointerId) {
      activePointerId = null;
    }
  }

  // Close on true outside *click* only (not during scroll)
  function onDocumentClick(e) {
    if (!isMobile()) return;
    const root = navRoot();
    if (!root) return;
    if (!isInside(e.target, root) && openToggle) {
      closeAllMenus();
      startGuard();
    }
  }

  // Prevent outside-close while scrolling menu: stop bubbling inside menus.
  function attachMenuScrollGuards(root) {
    root.querySelectorAll('.' + MENU_CLASS).forEach(m => {
      m.addEventListener('pointerdown', e => e.stopPropagation(), { passive: true });
      m.addEventListener('pointerup',   e => e.stopPropagation(), { passive: true });
      m.addEventListener('click',       e => e.stopPropagation(), true); // capture
    });
  }

  function onKeyDown(e) {
    if (e.key === 'Escape' && openToggle) { closeAllMenus(); startGuard(); }
  }

  function onResize() {
    if (!isMobile()) {
      closeAllMenus();
      guardUntil = 0;
      const root = navRoot();
      if (root) root.classList.remove(ROOT_GUARD_CLASS);
    }
  }

  // ====== INIT ======
  document.addEventListener('DOMContentLoaded', function () {
    const root = navRoot();
    if (!root) return;

    // Ensure menus start hidden for mobile
    root.querySelectorAll('.' + MENU_CLASS).forEach(m => { m.style.display = 'none'; });

    // Pointer gesture tracking (don’t act on pointerdown; decide on pointerup)
    root.addEventListener('pointerdown', onPointerDownStart, { passive: true });
    root.addEventListener('pointermove', onPointerMoveTrack, { passive: true });
    root.addEventListener('pointerup',   onPointerUpWithinNav, { passive: false });
    root.addEventListener('pointercancel', onPointerCancel, { passive: true });

    // Close on real outside clicks only
    document.addEventListener('click', onDocumentClick, true);
    document.addEventListener('keydown', onKeyDown, false);
    window.addEventListener('resize', onResize);

    attachMenuScrollGuards(root);

    console.log('Mobile nav: drag-safe tap detection + transitions loaded.');
  });
})();
</script>
