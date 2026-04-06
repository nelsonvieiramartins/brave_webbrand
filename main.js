document.addEventListener('DOMContentLoaded', () => {
  // Mobile Menu Toggle
  const btnMobileMenu = document.getElementById('btn-mobile-menu');
  const desktopNav = document.querySelector('.desktop-nav');

  if (btnMobileMenu && desktopNav) {
    btnMobileMenu.addEventListener('click', () => {
      // Toggle a simple mobile menu state
      // (In a full implementation, you'd add a dedicated mobile menu overlay here)
      const isVisible = desktopNav.style.display === 'flex';
      desktopNav.style.display = isVisible ? 'none' : 'flex';
      
      // Basic responsive fixes on toggle (for absolute overlay if needed)
      if (!isVisible) {
        desktopNav.style.position = 'absolute';
        desktopNav.style.top = '96px';
        desktopNav.style.left = '0';
        desktopNav.style.width = '100%';
        desktopNav.style.backgroundColor = 'rgba(255, 255, 255, 0.95)';
        desktopNav.style.flexDirection = 'column';
        desktopNav.style.padding = '20px 0';
        desktopNav.style.borderBottom = '1px solid var(--color-gray-200)';
      } else {
        desktopNav.style = '';
      }
    });
  }

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      if(this.getAttribute('href') !== '#') {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
          behavior: 'smooth'
        });
      }
    });
  });
});
