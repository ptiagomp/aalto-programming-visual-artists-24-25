// Interactive Generative Project: Dynamic Field

ArrayList<Particle> particles; // ArrayList to store particles
String mode = "attract"; // Default interaction mode
color bgColor = color(20); // Background color
boolean isPaused = false; // Pause state

void setup() {
  size(800, 600);
  particles = new ArrayList<Particle>(); // Initialize particle system
  background(bgColor); // Set initial background
}

void draw() {
  if (!isPaused) {
    fill(bgColor, 25); // Semi-transparent background for smooth trails
    rect(0, 0, width, height);

    // Update and display all particles
    for (Particle p : particles) {
      p.update();
      p.display();
    }
  }

  // Display current mode on screen
  fill(255);
  textSize(16);
  text("Mode: " + mode + " | Press 'r' to reset | Space to pause", 10, height - 20);
}

// Particle class definition
class Particle {
  float x, y;        // Position
  float vx, vy;      // Velocity
  float size;        // Size of the particle
  color c;           // Color of the particle

  Particle(float startX, float startY) {
    x = startX;
    y = startY;
    vx = random(-2, 2); // Random initial velocity
    vy = random(-2, 2);
    size = random(5, 15); // Random size
    c = color(random(100, 255), random(100, 255), random(100, 255)); // Random color
  }

  void update() {
    if (mode.equals("attract")) {
      // Move toward the mouse position
      float attractionStrength = 0.02;
      vx += (mouseX - x) * attractionStrength;
      vy += (mouseY - y) * attractionStrength;
    } else if (mode.equals("repel")) {
      // Move away from the mouse position
      float repulsionStrength = -0.02;
      vx += (mouseX - x) * repulsionStrength;
      vy += (mouseY - y) * repulsionStrength;
    } else if (mode.equals("random")) {
      // Add random jitter to velocity
      vx += random(-0.5, 0.5);
      vy += random(-0.5, 0.5);
    }

    // Update position based on velocity
    x += vx;
    y += vy;

    // Dampen velocity slightly for smoother motion
    vx *= 0.95;
    vy *= 0.95;

    // Wrap around screen edges for continuous motion
    if (x < 0) x = width;
    if (x > width) x = 0;
    if (y < 0) y = height;
    if (y > height) y = 0;
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, size, size); // Draw particle as a circle
  }
}

// Mouse interaction: Add particles on click or drag
void mouseDragged() {
  particles.add(new Particle(mouseX, mouseY));
}

// Keyboard interaction: Change modes or reset canvas
void keyPressed() {
  if (key == 'r') {
    particles.clear(); // Clear all particles
    background(bgColor); // Reset background
  } else if (key == ' ') {
    isPaused = !isPaused; // Toggle pause state
  } else if (key == '1') {
    mode = "attract"; // Switch to attract mode
  } else if (key == '2') {
    mode = "repel"; // Switch to repel mode
  } else if (key == '3') {
    mode = "random"; // Switch to random motion mode
  }
}