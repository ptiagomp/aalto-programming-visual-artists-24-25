import processing.video.*;

Capture cam;
PImage prevFrame;
PImage motionMask;  // Stores motion-based pixels

int segments = 6;   // Number of kaleidoscopic segments
float threshold = 25; // Brightness difference threshold for motion

void setup() {
  size(640, 480);
  frameRate(30);

  // Initialize camera
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
  if (cam.available()) {
    cam.read();

    // Initialize prevFrame & motionMask if this is the first valid frame
    if (prevFrame == null) {
      prevFrame = createImage(cam.width, cam.height, RGB);
      prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
      motionMask = createImage(cam.width, cam.height, ARGB);
      return;
    }

    // 1) Build a mask of only the pixels that moved
    detectMotion();

    // 2) Draw the kaleidoscope using the motionMask
    background(0);
    translate(width/2, height/2);

    // We’ll render the mask multiple times in a circular fashion
    float angleStep = 360.0 / segments;
    for (int i = 0; i < segments; i++) {
      pushMatrix();
      rotate(radians(angleStep * i));

      // Optional: flip every other segment to create a mirror effect
      // if (i % 2 == 0) scale(-1, 1);

      // Draw the motionMask, centered
      imageMode(CENTER);
      // Scale it down if you prefer to see more segments
      image(motionMask, 0, 0, width, height); 
      popMatrix();
    }

    // 3) Save current frame for next iteration
    prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
  }
}

// --------------------------------------------------------
// DETECT MOTION + BUILD MOTION MASK
// --------------------------------------------------------
void detectMotion() {
  cam.loadPixels();
  prevFrame.loadPixels();
  motionMask.loadPixels();
  
  for (int i = 0; i < cam.pixels.length; i++) {
    float currentB = brightness(cam.pixels[i]);
    float previousB = brightness(prevFrame.pixels[i]);
    float diff = abs(currentB - previousB);

    // If there's enough difference (motion), keep the pixel color; else transparent
    if (diff > threshold) {
      motionMask.pixels[i] = cam.pixels[i]; // Show live camera color at this pixel
    } else {
      // Make it fully transparent (no movement)
      motionMask.pixels[i] = color(0, 0);
    }
  }
  motionMask.updatePixels();
}

// --------------------------------------------------------
// OPTIONAL CONTROLS
// --------------------------------------------------------
void keyPressed() {
  // Adjust motion sensitivity
  if (key == '+') {
    threshold++;
    println("Threshold: " + threshold);
  } else if (key == '-' && threshold > 0) {
    threshold--;
    println("Threshold: " + threshold);
  }
  
  // Increase or decrease kaleidoscope segments
  if (key == 's') {
    segments = max(1, segments - 1);
    println("Segments: " + segments);
  } else if (key == 'S') {
    segments++;
    println("Segments: " + segments);
  }
}