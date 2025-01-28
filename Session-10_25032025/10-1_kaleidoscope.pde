import processing.video.*;

Capture cam;

// How many mirrored segments to display
int segments = 6;

void setup() {
  size(640, 480);
  // Initialize camera (use the default camera device)
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("No cameras available!");
    exit();
  } else {
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  background(0);
  
  // Translate to center of the screen for radial symmetry
  translate(width/2, height/2);
  
  // Draw multiple mirrored segments
  for (int i = 0; i < segments; i++) {
    pushMatrix();
    // Rotate the camera image for each segment
    rotate(radians((360.0 / segments) * i));
    
    // Mirror the segment by flipping horizontally
    scale(random(1.0, 1.2), 1);  // Slight random scale for a wavy effect
    if (i % 2 == 0) {
      scale(-1, 1);             // Flip horizontally on even segments
    }
    
    // Draw a portion of the camera feed
    // Using imageMode(CENTER) so it rotates around the center
    imageMode(CENTER);
    image(cam, 0, 0, 300, 300); // Adjust size to fit your design
    popMatrix();
  }
}

// Optionally, let the user change the kaleidoscope segments in real time
void keyPressed() {
  if (key == '+') {
    segments++;
  } else if (key == '-' && segments > 1) {
    segments--;
  }
}