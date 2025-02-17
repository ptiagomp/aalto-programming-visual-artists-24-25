// Colorful Particle System with Blur Effect

ArrayList<Particle> particles; // ArrayList to store particles

void setup() {
  size(800, 600);
  particles = new ArrayList<Particle>(); // Initialize the particle system
  background(0); // Black background for better contrast with colors
}

void draw() {
  // Create a blur effect by overlaying a semi-transparent black rectangle
  fill(0, 20); // Low opacity for smooth fading trails
  rect(0, 0, width, height);

  // Add new particles to the system
  for (int i = 0; i < 5; i++) {
    particles.add(new Particle(random(width), random(height))); // Random initial positions
  }

  // Update and display all particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update(); // Update particle behavior
    p.display(); // Draw the particle

    // Remove the particle if it is "dead" (fully faded out)
    if (p.isDead()) {
      particles.remove(i);
    }
  }
}

// Particle class definition
class Particle {
  float x, y;        // Position of the particle
  float vx, vy;      // Velocity of the particle
  float lifespan;    // Lifespan of the particle (fades out over time)
  color c;           // Color of the particle

  Particle(float startX, float startY) {
    x = startX;
    y = startY;
    vx = random(-2, 2); // Random horizontal velocity
    vy = random(-2, 2); // Random vertical velocity
    lifespan = 255;     // Initial lifespan (fully visible)
    
    // Assign a random bright color to each particle
    c = color(random(100, 255), random(100, 255), random(100, 255), lifespan);
  }

  void update() {
    // Update position based on velocity
    x += vx;
    y += vy;

    // Add attraction to mouse position
    float attractionStrength = 0.05;
    vx += (mouseX - x) * attractionStrength * random(0.8, 1.2);
    vy += (mouseY - y) * attractionStrength * random(0.8, 1.2);

    // Dampen velocity slightly to prevent excessive acceleration
    vx *= 0.95;
    vy *= 0.95;

    // Reduce lifespan to create a fading effect
    lifespan -= random(2, 5);

    // Update color transparency as the particle fades out
    c = color(red(c), green(c), blue(c), lifespan);

    // Keep particles within screen bounds (optional)
    if (x < 0 || x > width) vx *= -1;
    if (y < 0 || y > height) vy *= -1;
  }

  void display() {
    noStroke();
    
    // Draw a glowing circle with gradient-like fill using ellipse layers
    for (int i = int(lifespan / 50); i > 0; i--) {
      fill(red(c), green(c), blue(c), lifespan / (i * i)); 
      ellipse(x, y, i * random(8,12), i * random(8,12));
    }
    
    fill(c); 
    ellipse(x, y, random(10,15),random(10));
   }
  
   boolean isDead() {
      return lifespan <=0;}
}