import processing.video.*;

Capture cam;
PImage prevFrame;

// Store shockwaves in a list
ArrayList<Shockwave> shockwaves = new ArrayList<>();

// Motion detection threshold (tweak for sensitivity)
float threshold = 25;

// Sampling step: skip this many pixels each time (bigger = faster, coarser detection)
int stepSize = 4;

// Maximum number of shockwaves spawned per detected motion
int maxShockwavesPerHit = 5;

// A rough limit on how many shockwaves can exist at once
int maxShockwaves = 2000;

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

    // Initialize prevFrame if needed
    if (prevFrame == null) {
      prevFrame = createImage(cam.width, cam.height, RGB);
      prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
      return;
    }

    // Detect motion at a lower resolution
    detectMotionAndSpawnShockwaves();

    // Semi-transparent background for trailing effect
    fill(0, 30);
    noStroke();
    rect(0, 0, width, height);

    // Update and draw shockwaves
    for (int i = shockwaves.size() - 1; i >= 0; i--) {
      Shockwave sw = shockwaves.get(i);
      sw.update();
      sw.display();
      if (sw.isDone()) {
        shockwaves.remove(i);
      }
    }

    // Save current frame
    prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
  }
}

void detectMotionAndSpawnShockwaves() {
  cam.loadPixels();
  prevFrame.loadPixels();

  // Only compare every "stepSize" pixels for performance
  for (int y = 0; y < cam.height; y += stepSize) {
    for (int x = 0; x < cam.width; x += stepSize) {
      int loc = x + y * cam.width;
      float currentBrightness = brightness(cam.pixels[loc]);
      float prevBrightness = brightness(prevFrame.pixels[loc]);
      float diff = abs(currentBrightness - prevBrightness);

      if (diff > threshold) {
        // Scale camera coords to window size
        float scaleX = (float) width / cam.width;
        float scaleY = (float) height / cam.height;
        float xScreen = x * scaleX;
        float yScreen = y * scaleY;

        // Sample color from camera
        color motionColor = cam.pixels[loc];

        // Spawn multiple shockwaves if we haven't reached the max limit
        int howMany = int(random(2, maxShockwavesPerHit + 1));
        for (int i = 0; i < howMany; i++) {
          if (shockwaves.size() < maxShockwaves) {
            // Slight random offsets so they spread out
            float offsetX = random(-stepSize, stepSize) * 0.5 * scaleX;
            float offsetY = random(-stepSize, stepSize) * 0.5 * scaleY;
            shockwaves.add(new Shockwave(xScreen + offsetX, yScreen + offsetY, motionColor));
          }
        }
      }
    }
  }
}

// --------------------------------------------------------
// SHOCKWAVE CLASS
// --------------------------------------------------------
class Shockwave {
  float x, y;
  float radius = 0;
  float maxRadius;
  float expansionSpeed;
  color c;
  float alpha = 255;

  Shockwave(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;

    // Randomize shockwave properties for variety
    this.maxRadius = random(100, 300);
    this.expansionSpeed = random(4, 8);
  }

  void update() {
    radius += expansionSpeed;
    alpha -= expansionSpeed * 1.2;  // Fade out quicker as ring expands
  }

  void display() {
    strokeWeight(3);
    stroke(red(c), green(c), blue(c), alpha);
    noFill();
    ellipse(x, y, radius, radius);
  }

  boolean isDone() {
    return (radius > maxRadius || alpha < 0);
  }
}

// --------------------------------------------------------
// OPTIONAL KEY CONTROLS
// --------------------------------------------------------
void keyPressed() {
  // Increase / decrease threshold
  if (key == '+' || key == '=') {
    threshold++;
    println("Threshold: " + threshold);
  } else if (key == '-' && threshold > 0) {
    threshold--;
    println("Threshold: " + threshold);
  }
  
  // Increase / decrease stepSize
  if (key == 'u') {
    stepSize = max(1, stepSize - 1);
    println("stepSize: " + stepSize);
  } else if (key == 'd') {
    stepSize++;
    println("stepSize: " + stepSize);
  }
}
