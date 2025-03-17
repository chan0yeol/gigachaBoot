(function() {
    "use strict";
  
    const select = (el, all = false) => {
        if (!el) return null;
        el = el.trim();
        return all ? [...document.querySelectorAll(el)] : document.querySelector(el);
    };

    const on = (type, el, listener, all = false) => {
        let elements = select(el, all);
        if (!elements) return;
        if (all) {
            elements.forEach(e => e.addEventListener(type, listener));
        } else {
            elements.addEventListener(type, listener);
        }
    };

    const debounce = (func, wait = 100) => {
        let timeout;
        return (...args) => {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    };

    if (select('.toggle-sidebar-btn')) {
        on('click', '.toggle-sidebar-btn', function() {
            select('body').classList.toggle('toggle-sidebar');
        });
    }

    if (select('.search-bar-toggle')) {
        on('click', '.search-bar-toggle', function() {
            select('.search-bar').classList.toggle('search-bar-show');
        });
    }

    let navbarlinks = select('#navbar .scrollto', true);
    const navbarlinksActive = () => {
        let position = window.scrollY + 200;
        navbarlinks.forEach(navbarlink => {
            if (!navbarlink.hash) return;
            let section = select(navbarlink.hash);
            if (!section || !section.offsetTop) return;
            if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
                navbarlink.classList.add('active');
            } else {
                navbarlink.classList.remove('active');
            }
        });
    };
    window.addEventListener('load', navbarlinksActive);
    window.addEventListener('scroll', debounce(navbarlinksActive, 100));

    let selectHeader = select('#header');
    if (selectHeader) {
        const headerScrolled = () => {
            selectHeader.classList.toggle('header-scrolled', window.scrollY > 100);
        };
        window.addEventListener('load', headerScrolled);
        window.addEventListener('scroll', debounce(headerScrolled, 100));
    }
})();
