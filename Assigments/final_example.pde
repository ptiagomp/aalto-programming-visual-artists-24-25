// Interactive Generative Project: Dynamic Field

ArrayList<Particle> particles; // ArrayList to store particles
String mode = "attract";         // Default interaction mode
color bgColor = color(20);       // Background color
boolean isPaused = false;        // Pause state

// Constants for particle behavior
final float ATTRACT_STRENGTH = 0.02;
final float REPEL_STRENGTH   = -0.02;
final float RANDOM_JITTER    = 0.5;
final float DAMPING          = 0.95;

void setup() {
  size(800, 600);
  particles = new ArrayList<Particle>();
  background(bgColor);
  noStroke();
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

  // Display current mode and instructions on screen
  fill(255);
  textSize(16);
  text("Mode: " + mode + " | Press 'r' to reset | Space to pause", 10, height - 20);
}

class Particle {
  float x, y;   // Position
  float vx, vy; // Velocity
  float size;   // Size of the particle
  color c;      // Color of the particle

  Particle(float startX, float startY) {
    x = startX;
    y = startY;
    vx = random(-2, 2);
    vy = random(-2, 2);
    size = random(5, 15);
    c = color(random(100, 255), random(100, 255), random(100, 255));
  }

  void update() {
    // Cache mouse difference values for efficiency
    float dx = mouseX - x;
    float dy = mouseY - y;

    // Adjust velocity based on current mode
    if (mode.equals("attract")) {
      vx += dx * ATTRACT_STRENGTH;
      vy += dy * ATTRACT_STRENGTH;
    } else if (mode.equals("repel")) {
      vx += dx * REPEL_STRENGTH;
      vy += dy * REPEL_STRENGTH;
    } else if (mode.equals("random")) {
      vx += random(-RANDOM_JITTER, RANDOM_JITTER);
      vy += random(-RANDOM_JITTER, RANDOM_JITTER);
    }

    // Update position
    x += vx;
    y += vy;

    // Apply damping for smoother motion
    vx *= DAMPING;
    vy *= DAMPING;

    // Wrap around screen edges for continuous motion
    if (x < 0) {
      x = width;
    } else if (x > width) {
      x = 0;
    }
    if (y < 0) {
      y = height;
    } else if (y > height) {
      y = 0;
    }
  }

  void display() {
    fill(c);
    ellipse(x, y, size, size);
  }
}

void mouseDragged() {
  particles.add(new Particle(mouseX, mouseY));
}

void keyPressed() {
  if (key == 'r') {
    particles.clear();
    background(bgColor);
  } else if (key == ' ') {
    isPaused = !isPaused;
  } else if (key == '1') {
    mode = "attract";
  } else if (key == '2') {
    mode = "repel";
  } else if (key == '3') {
    mode = "random";
  }
}