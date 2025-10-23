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
/* ====== Mobile menu show/hide button (unchanged) ====== */
$('button.navbar-toggler').click(function(){
  $('.wrap-for-mobile-menu').toggleClass('show');
  $('.mobile-collapse').toggleClass('show');
  $('body').toggleClass('absolute-fix');
});

/* ====== Mobile dropdown nav: drag-safe taps, transitions, caret toggle, hint pulse (<= 991px) ====== */
(function () {
  'use strict';

  // ====== CONFIG ======
  const NAV_ROOT_ID   = 'navbarMobileNav';
  const TOGGLE_CLASS  = 'dropdown-toggle'; // usually on <li> wrapper
  const MENU_CLASS    = 'dropdown-menu';
  const LINK_SELECTOR = 'a';

  const MOBILE_MAX_WIDTH = 991;  // treat <= 991px as "mobile"
  const DELAY_MS   = 450;        // tap-guard after open/close
  const TOUCH_SLOP = 12;         // px movement allowed to still count as tap

  const ROOT_GUARD_CLASS = 'tap-guard-active';

  // ====== STATE ======
  let guardUntil = 0;
  let openToggle = null;

  // Active-pointer state for tap vs drag
  let activePointerId = null;
  let downX = 0, downY = 0, moved = false;

  // ====== HELPERS ======
  const now      = () => performance.now();
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

  function isInside(el, container) { return !!(el && container && container.contains(el)); }

  function findMenu(toggleEl) {
    if (!toggleEl) return null;
    const scope = toggleEl.closest('li, .nav-item, .dropdown') || toggleEl;
    return scope ? scope.querySelector('.' + MENU_CLASS) : null;
  }

  function closeAllMenus(exceptToggle) {
    const root = navRoot();
    if (!root) return;
    root.querySelectorAll('.' + TOGGLE_CLASS + '.is-open').forEach(t => {
      if (t !== exceptToggle) closeMenu(t);
    });
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

    // initial collapsed state
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
    // force reflow
    // eslint-disable-next-line no-unused-expressions
    menu.offsetHeight;

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

  function getToggleFromTarget(target) { return target.closest('.' + TOGGLE_CLASS); }
  function getMenuLinkFromTarget(target) {
    const link = target.closest(LINK_SELECTOR);
    if (!link) return null;
    return link.closest('.' + MENU_CLASS) ? link : null;
  }

  // ====== POINTER (tap vs drag) ======
  function onPointerDownStart(e) {
    if (!isMobile()) return;
    const root = navRoot();
    if (!root || !isInside(e.target, root)) return;
    if (activePointerId !== null) return; // track a single pointer

    activePointerId = e.pointerId;
    downX = e.clientX;
    downY = e.clientY;
    moved = false;
    // Do not preventDefault; allow natural scrolling.
  }

  function onPointerMoveTrack(e) {
    if (!isMobile()) return;
    if (activePointerId === null || e.pointerId !== activePointerId) return;
    if (!moved) {
      const dx = Math.abs(e.clientX - downX);
      const dy = Math.abs(e.clientY - downY);
      if (dx > TOUCH_SLOP || dy > TOUCH_SLOP) moved = true; // scrolling
    }
  }

  function onPointerUpWithinNav(e) {
    if (!isMobile()) return;
    if (activePointerId === null || e.pointerId !== activePointerId) return;

    const root = navRoot();
    const upTarget = e.target;
    activePointerId = null; // reset pointer tracking

    if (moved) return; // treated as scroll — do nothing
    if (!root || !isInside(upTarget, root)) return;

    const clickedToggle   = getToggleFromTarget(upTarget);
    const clickedMenuLink = getMenuLinkFromTarget(upTarget);

    // Tapped a dropdown toggle (includes taps on the <a> inside the toggle)
    if (clickedToggle) {
      if (inGuard() && clickedToggle !== openToggle) {
        e.preventDefault(); e.stopPropagation(); return;
      }
      const isOpen = clickedToggle.classList.contains('is-open');

      // Behavior A:
      // First tap on link text (menu closed) => OPEN (no navigate)
      // Second tap on link text (menu open)  => FOLLOW (allow default)
      if (!isOpen) {
        e.preventDefault(); e.stopPropagation();
        openMenu(clickedToggle);
        startGuard();
        return;
      } else {
        if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
        // Allow default navigation on the second tap
      }
    }

    // Tapped a link inside an open dropdown menu
    if (clickedMenuLink) {
      if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
      closeAllMenus();
      // allow natural navigation
    }
  }

  function onPointerCancel(e) {
    if (!isMobile()) return;
    if (e.pointerId === activePointerId) activePointerId = null;
  }

  // ====== CRITICAL FIX: intercept link "click" when menu is closed ======
  // Some browsers will still follow the link unless we stop the click event.
  function onClickWithinNav(e) {
    if (!isMobile()) return;

    const root = navRoot();
    if (!root || !isInside(e.target, root)) return;

    // Ignore clicks inside dropdown menus (let them navigate normally)
    if (e.target.closest('.' + MENU_CLASS)) return;

    const link = e.target.closest('a');
    if (!link) return;

    // Let the dedicated caret handler take over if caret was tapped
    if (e.target.closest('.mobile-caret')) {
      e.preventDefault();
      e.stopPropagation();
      return;
    }

    const toggle = link.closest('.' + TOGGLE_CLASS);
    if (!toggle) return;

    const isOpen = toggle.classList.contains('is-open');

    if (!isOpen) {
      // FIRST CLICK on link text when closed → open (do NOT navigate)
      e.preventDefault();
      e.stopPropagation();
      openMenu(toggle);
      startGuard();
      return;
    } else {
      // SECOND CLICK with menu already open → allow navigation unless in guard
      if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
      // else fall through: browser navigates
    }
  }

  // Close on true outside click only (not during scroll)
  function onDocumentClick(e) {
    if (!isMobile()) return;
    const root = navRoot();
    if (!root) return;
    if (!isInside(e.target, root) && openToggle) {
      closeAllMenus();
      startGuard();
    }
  }

  // Prevent outside-close while interacting inside menus
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

  // ====== CARET HINT: "tap again to visit" pulse on link text ======
  function initCaretHint() {
    const root = navRoot();
    if (!root) return;

    // Ensure li.has-sub exists wherever there is a submenu (keeps CSS in sync if used)
    root.querySelectorAll('li').forEach(li => {
      if (li.querySelector('.' + MENU_CLASS)) li.classList.add('has-sub');
    });

    // If the toggle isn't the <a> itself, use nearest link for the hint class.
    function nearestLinkOrSelf(el) {
      if (!el) return null;
      if (el.matches && el.matches('a')) return el;
      const a = el.querySelector && el.querySelector(':scope > a, a');
      return a || el;
    }

    const obs = new MutationObserver(muts => {
      for (const m of muts) {
        if (m.type !== 'attributes' || m.attributeName !== 'class') continue;
        const el = m.target;
        if (!el.classList || !el.classList.contains(TOGGLE_CLASS)) continue;

        const link = nearestLinkOrSelf(el);
        if (!link) continue;

        if (el.classList.contains('is-open')) {
          // Restart animation reliably: remove then re-add after a reflow tick
          link.classList.remove('hint-next-tap');
          void link.offsetWidth; // force reflow
          link.classList.add('hint-next-tap');

          // Auto-clear after animation, or on next user action
          clearTimeout(link._hintTimer);
          link._hintTimer = setTimeout(() => link.classList.remove('hint-next-tap'), 1400);

          const clear = () => link.classList.remove('hint-next-tap');
          link.addEventListener('pointerdown', clear, { once: true, passive: true });
          link.addEventListener('click',       clear, { once: true, capture: true });
        } else {
          link.classList.remove('hint-next-tap');
          clearTimeout(link._hintTimer);
        }
      }
    });

    obs.observe(root, { subtree: true, attributes: true, attributeFilter: ['class'] });
  }

  // ====== REAL, TAPPABLE CARET BUTTONS (toggle-only) ======
  function injectCaretButtons() {
    const root = navRoot();
    if (!root) return;

    root.querySelectorAll('.' + TOGGLE_CLASS).forEach(toggle => {
      const link = toggle.querySelector(':scope > a') || toggle.querySelector('a');
      const menu = findMenu(toggle);
      if (!link || !menu) return;

      // Avoid duplicates
      if (link.querySelector('.mobile-caret')) return;

      // Mark has-sub for CSS hooks (if used)
      link.closest('li')?.classList.add('has-sub');

      // Create caret hit target
      const caret = document.createElement('span');
      caret.className = 'mobile-caret';
      caret.setAttribute('role', 'button');
      caret.setAttribute('tabindex', '-1');
      caret.setAttribute('aria-label', 'Toggle menu');
      link.appendChild(caret);

      // Pointer handler for caret taps (toggle-only)
      const onCaretTap = (e) => {
        if (!isMobile()) return; // only special behavior on mobile
        e.preventDefault();
        e.stopPropagation();

        const isOpen = toggle.classList.contains('is-open');
        if (isOpen) {
          closeMenu(toggle);          // collapse if open
        } else {
          openMenu(toggle);           // expand if closed
          // Do not consume link's two-tap behavior
        }
        startGuard();
      };

      caret.addEventListener('pointerup', onCaretTap, { passive: false });
      caret.addEventListener('click', onCaretTap, { capture: true });
    });
  }

  // ====== INIT ======
  function init() {
    const root = navRoot();
    if (!root) return;

    // Start with menus hidden
    root.querySelectorAll('.' + MENU_CLASS).forEach(m => { m.style.display = 'none'; });

    // Gesture tracking — decide on pointerup (not pointerdown)
    root.addEventListener('pointerdown',  onPointerDownStart, { passive: true });
    root.addEventListener('pointermove',  onPointerMoveTrack, { passive: true });
    root.addEventListener('pointerup',    onPointerUpWithinNav, { passive: false });
    root.addEventListener('pointercancel', onPointerCancel, { passive: true });

    // CRITICAL: capture-phase click interceptor to block first-click navigation
    root.addEventListener('click', onClickWithinNav, true);

    // Global listeners
    document.addEventListener('click', onDocumentClick, true);
    document.addEventListener('keydown', onKeyDown, false);
    window.addEventListener('resize', onResize);

    // Keep outside-close from firing during menu interactions
    attachMenuScrollGuards(root);

    // Caret hint observer (pulses the link on first open)
    initCaretHint();

    // Build tappable carets
    injectCaretButtons();

    console.log('Mobile nav (<=991px): 2-tap links (fixed), caret toggle-only, drag-safe, transitions, hint pulse.');
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
</script>
<style>
/* === Mobile nav caret + rotate + first-tap pulse (CF-safe: double ##) === */

/* Desktop: no overrides — desktop carets/icons remain as-is. */

/* MOBILE-ONLY rules (<= 991px) */
@media (hover: none), (pointer: coarse), (max-width: 991px) {

  /* Hide any framework/injected caret on mobile only */
  .dropdown-toggle::after { display: none !important; }

  /* Also hide inline caret elements some themes add (mobile only) */
  ##navbarMobileNav .nav-list .dropdown-toggle .caret,
  ##navbarMobileNav .nav-list .dropdown-toggle .caret-icon,
  ##navbarMobileNav .nav-list .dropdown-toggle svg.caret,
  ##navbarMobileNav .nav-list .dropdown-toggle svg.caret-icon {
    display: none !important;
  }

  /* Our single caret (mobile only): draw it on li.has-sub > a */
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
    transition: transform 200ms ease;   /* smooth rotation */
    width: 0; height: 0;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-top: 6px solid currentColor; /* small down arrow */
    pointer-events: none;
    display: inline-block;
  }

  /* Rotate caret when open — supports li.open and a.is-open */
  ##navbarMobileNav .nav-list li.open > a::after,
  ##navbarMobileNav .nav-list li.has-sub > a.is-open::after {
    transform: translateY(-50%) rotate(180deg);
  }

  /* First-tap hint pulse (after rotate completes) */
  ##navbarMobileNav .nav-list li.has-sub > a.hint-next-tap::after {
    animation: caretPulseOpen 900ms ease-out 120ms 1 both;
  }

  @keyframes caretPulseOpen {
    0%   { transform: translateY(-50%) rotate(180deg) scale(1);     filter: drop-shadow(0 0 0 rgba(0,0,0,0)); opacity: .95; }
    40%  { transform: translateY(calc(-50% - 1px)) rotate(180deg) scale(1.28); filter: drop-shadow(0 1px 0 rgba(0,0,0,.2)); opacity: 1; }
    100% { transform: translateY(-50%) rotate(180deg) scale(1);     filter: drop-shadow(0 0 0 rgba(0,0,0,0)); opacity: 1; }
  }
  /* Make the whole link enlarge/pulse just like the caret */
  ##navbarMobileNav .nav-list li.has-sub > a.hint-next-tap {
      animation: linkPulseOpen 900ms ease-out 120ms 1 both;
        display: inline-block; /* allows transform scaling without layout weirdness */
          transform-origin: center;
  }

  @keyframes linkPulseOpen {
      0%   { transform: scale(1); opacity: .95; }
        40%  { transform: scale(1.28); opacity: 1; }
          100% { transform: scale(1); opacity: 1; }
  }
/* Replace the ::after caret with a real, tappable caret button */
##navbarMobileNav .nav-list li.has-sub > a::after {
    display: none !important; /* hide the pseudo-caret */
}

/* Create a real caret hit target */
##navbarMobileNav .nav-list li.has-sub > a {
    position: relative;
      padding-right: 1.75rem; /* a bit more room for the caret hit area */
}

/* The tappable caret element we'll inject via JS */
##navbarMobileNav .nav-list li.has-sub > a .mobile-caret {
    position: absolute;
      right: 0.35rem;
        top: 50%;
          transform: translateY(-50%) rotate(0deg);
            transition: transform 200ms ease;
              width: 22px;
                height: 22px;
                  display: inline-flex;
                    align-items: center;
                      justify-content: center;
                        pointer-events: auto; /* ensure taps go to the caret span */
                          -webkit-tap-highlight-color: transparent;
}

/* Draw the triangle arrow */
##navbarMobileNav .nav-list li.has-sub > a .mobile-caret::before {
    content: "";
      display: block;
        width: 0; height: 0;
          border-left: 6px solid transparent;
            border-right: 6px solid transparent;
              border-top: 8px solid currentColor; /* down arrow */
}

/* Rotate caret when its parent toggle (the LI/.dropdown-toggle) is open */
##navbarMobileNav .nav-list .dropdown-toggle.is-open > a .mobile-caret {
    transform: translateY(-50%) rotate(180deg);
}

/* Keep your first-tap pulse for the whole link */
##navbarMobileNav .nav-list li.has-sub > a.hint-next-tap {
    animation: linkPulseOpen 900ms ease-out 120ms 1 both;
      display: inline-block;
        transform-origin: center;
}
@keyframes linkPulseOpen {
    0%   { transform: scale(1); opacity: .95; }
      40%  { transform: scale(1.28); opacity: 1; }
        100% { transform: scale(1); opacity: 1; }
}
}
}
}
}
}
}
}
  /* Respect reduced motion */
  @media (prefers-reduced-motion: reduce) {
      ##navbarMobileNav .nav-list li.has-sub > a.hint-next-tap {
            animation: none !important;
      }
  }
      }
  }
  }
  }
      }
  }
  }
  }
}

/* Respect reduced motion */
@media (prefers-reduced-motion: reduce) {
  ##navbarMobileNav .nav-list li.has-sub > a.hint-next-tap::after {
    animation: none !important;
  }
}
</style>
</cfoutput>
<script>
/* === Mobile dropdown nav: drag-safe + transitions + caret hint (<= 991px) === */
(function () {
  'use strict';

  // ====== CONFIG ======
  const NAV_ROOT_ID   = 'navbarMobileNav';
  const TOGGLE_CLASS  = 'dropdown-toggle';
  const MENU_CLASS    = 'dropdown-menu';
  const LINK_SELECTOR = 'a';

  const MOBILE_MAX_WIDTH = 991;  // treat <= 991px as "mobile"
  const DELAY_MS   = 450;        // tap-guard after open/close
  const TOUCH_SLOP = 12;         // px movement allowed to still count as tap
  const ROOT_GUARD_CLASS = 'tap-guard-active';

  // ====== STATE ======
  let guardUntil = 0;
  let openToggle = null;

  // Active-pointer state for tap vs drag
  let activePointerId = null;
  let downX = 0, downY = 0, moved = false;

  // ====== HELPERS ======
  const now      = () => performance.now();
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

  function isInside(el, container) { return !!(el && container && container.contains(el)); }

  function findMenu(toggleEl) {
    if (!toggleEl) return null;
    const scope = toggleEl.closest('li, .nav-item, .dropdown') || toggleEl;
    return scope ? scope.querySelector('.' + MENU_CLASS) : null;
  }

  function closeAllMenus(exceptToggle) {
    const root = navRoot();
    if (!root) return;
    root.querySelectorAll('.' + TOGGLE_CLASS + '.is-open').forEach(t => {
      if (t !== exceptToggle) closeMenu(t);
    });
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
    // force reflow
    // eslint-disable-next-line no-unused-expressions
    menu.offsetHeight;

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

  function getToggleFromTarget(target) { return target.closest('.' + TOGGLE_CLASS); }
  function getMenuLinkFromTarget(target) {
    const link = target.closest(LINK_SELECTOR);
    if (!link) return null;
    return link.closest('.' + MENU_CLASS) ? link : null;
  }

  // ====== POINTER (tap vs drag) ======
  function onPointerDownStart(e) {
    if (!isMobile()) return;
    const root = navRoot();
    if (!root || !isInside(e.target, root)) return;
    if (activePointerId !== null) return; // track a single pointer

    activePointerId = e.pointerId;
    downX = e.clientX;
    downY = e.clientY;
    moved = false;
    // Do not preventDefault; allow natural scrolling.
  }

  function onPointerMoveTrack(e) {
    if (!isMobile()) return;
    if (activePointerId === null || e.pointerId !== activePointerId) return;
    if (!moved) {
      const dx = Math.abs(e.clientX - downX);
      const dy = Math.abs(e.clientY - downY);
      if (dx > TOUCH_SLOP || dy > TOUCH_SLOP) moved = true; // scrolling
    }
  }

  function onPointerUpWithinNav(e) {
    if (!isMobile()) return;
    if (activePointerId === null || e.pointerId !== activePointerId) return;

    const root = navRoot();
    const upTarget = e.target;
    activePointerId = null; // reset pointer tracking

    if (moved) return; // treated as scroll — do nothing
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
        e.preventDefault(); e.stopPropagation();
        openMenu(clickedToggle);
        startGuard();
        return;
      } else {
        if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
        // otherwise allow default (e.g., navigate if it's also a link)
      }
    }

    // Tapped a link inside an open menu
    if (clickedMenuLink) {
      if (inGuard()) { e.preventDefault(); e.stopPropagation(); return; }
      closeAllMenus();
      // allow natural navigation
    }
  }

  function onPointerCancel(e) {
    if (!isMobile()) return;
    if (e.pointerId === activePointerId) activePointerId = null;
  }

  // Close on true outside click only (not during scroll)
  function onDocumentClick(e) {
    if (!isMobile()) return;
    const root = navRoot();
    if (!root) return;
    if (!isInside(e.target, root) && openToggle) {
      closeAllMenus();
      startGuard();
    }
  }

  // Prevent outside-close while interacting inside menus
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

  // ====== CARET HINT: "tap again to visit" pulse ======
  function initCaretHint() {
    const root = navRoot();
    if (!root) return;

    // Ensure li.has-sub exists wherever there is a submenu (matches CSS)
    root.querySelectorAll('li').forEach(li => {
      if (li.querySelector('.' + MENU_CLASS)) li.classList.add('has-sub');
    });

    // If the toggle isn't the <a> itself, use nearest link for the hint class.
    function nearestLinkOrSelf(el) {
      if (!el) return null;
      if (el.matches && el.matches('a')) return el;
      const a = el.querySelector && el.querySelector(':scope > a, a');
      return a || el;
    }

    const obs = new MutationObserver(muts => {
      for (const m of muts) {
        if (m.type !== 'attributes' || m.attributeName !== 'class') continue;
        const el = m.target;
        if (!el.classList || !el.classList.contains(TOGGLE_CLASS)) continue;

        const link = nearestLinkOrSelf(el);
        if (!link) continue;

        if (el.classList.contains('is-open')) {
          // Restart animation reliably: remove then re-add after a reflow tick
          link.classList.remove('hint-next-tap');
          void link.offsetWidth; // force reflow
          link.classList.add('hint-next-tap');

          // Auto-clear after animation window, or on next user action
          clearTimeout(link._hintTimer);
          link._hintTimer = setTimeout(() => link.classList.remove('hint-next-tap'), 1400);

          const clear = () => link.classList.remove('hint-next-tap');
          link.addEventListener('pointerdown', clear, { once: true, passive: true });
          link.addEventListener('click',       clear, { once: true, capture: true });
        } else {
          link.classList.remove('hint-next-tap');
          clearTimeout(link._hintTimer);
        }
      }
    });

    obs.observe(root, { subtree: true, attributes: true, attributeFilter: ['class'] });
  }

  // ====== INIT ======
  function init() {
    const root = navRoot();
    if (!root) return;

    // Start with menus hidden
    root.querySelectorAll('.' + MENU_CLASS).forEach(m => { m.style.display = 'none'; });

    // Gesture tracking — decide on pointerup (not pointerdown)
    root.addEventListener('pointerdown',  onPointerDownStart, { passive: true });
    root.addEventListener('pointermove',  onPointerMoveTrack, { passive: true });
    root.addEventListener('pointerup',    onPointerUpWithinNav, { passive: false });
    root.addEventListener('pointercancel', onPointerCancel, { passive: true });

    // Global listeners
    document.addEventListener('click', onDocumentClick, true);
    document.addEventListener('keydown', onKeyDown, false);
    window.addEventListener('resize', onResize);

    // Keep outside-close from firing during menu interactions
    attachMenuScrollGuards(root);

    // Caret hint observer
    initCaretHint();

    console.log('Mobile nav loaded (<=991px): drag-safe taps, transitions, caret hint.');
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
</script>