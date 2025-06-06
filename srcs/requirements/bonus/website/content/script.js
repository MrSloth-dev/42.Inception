// Simple interactive features
document.addEventListener('DOMContentLoaded', function() {
    // Add animation to services on scroll
    const services = document.querySelectorAll('.service');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    });
    
    services.forEach(service => {
        service.style.opacity = '0';
        service.style.transform = 'translateY(20px)';
        service.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(service);
    });
    
    // Add click counter for demo
    let clickCount = 0;
    document.querySelector('.hero').addEventListener('click', function() {
        clickCount++;
        console.log(`Hero clicked ${clickCount} times`);
    });
});
