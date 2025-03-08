ArrayList<Particle> particles;

void setup() {
  size(600, 400);
  particles = new ArrayList<Particle>();
}

void draw() {
  background(0);
  
  // Create new particles at the mouse position when the mouse is pressed
  if (mousePressed) {
    for (int i = 0; i < 5; i++) {
      particles.add(new Particle(mouseX, mouseY));
    }
  }
  
  // Update and display particles
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    
    // Remove particle if its lifespan is over
    if (p.isDead()) {
      particles.remove(i);
    }
  }
}

class Particle {
  PVector pos;
  PVector vel;
  float lifespan;
  
  Particle(float x, float y) {
    pos = new PVector(x, y);
    // Give a random velocity to create spread
    vel = PVector.random2D();
    vel.mult(random(1, 3));
    lifespan = 255;  // Start with a full brightness lifespan
  }
  
  // Update the particle's position and reduce its lifespan
  void update() {
    pos.add(vel);
    lifespan -= 2;
  }
  
  // Draw the particle with transparency based on its lifespan
  void display() {
    noStroke();
    fill(255, lifespan);
    ellipse(pos.x, pos.y, 8, 8);
  }
  
  // Check if the particle is "dead"
  boolean isDead() {
    return lifespan < 0;
  }
}