// Wait for the page to fully load
document.addEventListener('DOMContentLoaded', function() {
    console.log('Page loaded and ready!');

    // Button click example
    const button = document.getElementById('clickMe');
    const output = document.getElementById('output');
    let clickCount = 0;

    button.addEventListener('click', function() {
        clickCount++;
        output.textContent = `Button clicked ${clickCount} time${clickCount !== 1 ? 's' : ''}! 🎉`;
        output.style.display = 'block';
    });

    // Form submission example
    const form = document.getElementById('contactForm');

    form.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent page reload

        // Get form values
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const message = document.getElementById('message').value;

        // In a real app, you'd send this data to a server
        // For now, we'll just show an alert
        alert(`Thanks ${name}! Your message has been received.\n\nWe'll contact you at ${email} soon.`);

        // Log to console (check browser dev tools)
        console.log('Form submitted:', { name, email, message });

        // Reset the form
        form.reset();
    });

    // Smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('nav a');

    navLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault();
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);

            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Example: Function to get current date
function getCurrentDate() {
    const now = new Date();
    return now.toLocaleDateString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}

// Example: Function to greet user based on time
function getTimeBasedGreeting() {
    const hour = new Date().getHours();

    if (hour < 12) {
        return 'Good morning';
    } else if (hour < 18) {
        return 'Good afternoon';
    } else {
        return 'Good evening';
    }
}

// You can call these functions in the console to test them!
console.log('Current date:', getCurrentDate());
console.log('Greeting:', getTimeBasedGreeting());
