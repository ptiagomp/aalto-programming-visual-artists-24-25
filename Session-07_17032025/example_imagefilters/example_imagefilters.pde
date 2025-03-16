PImage img;
PImage originalImg;

void setup() {
  size(800, 600);
  img = loadImage("aalto.jpg");  // Load the image
  img.resize(width, height);  // Resize to fit the window
  originalImg = img.copy();  // Store the original image for resets
}

void draw() {
  background(0);
  image(img, 0, 0);
}

void invertImage(PImage img) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    img.pixels[i] = color(255 - red(c), 255 - green(c), 255 - blue(c));
  }
  img.updatePixels();
}

void grayscaleImage(PImage img) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float avg = (red(c) + green(c) + blue(c)) / 3;
    img.pixels[i] = color(avg, avg, avg);
  }
  img.updatePixels();
}

void thresholdImage(PImage img, float threshold) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float brightness = (red(c) + green(c) + blue(c)) / 3;
    img.pixels[i] = brightness > threshold * 255 ? color(255) : color(0);
  }
  img.updatePixels();
}

void blurImage(PImage img) {
  img.filter(BLUR, 6);  // Use filter on the image itself so it persists
}

void keyPressed() {
  if (key == 'i' || key == 'I') {
    invertImage(img);
  }
  if (key == 'b' || key == 'B') {
    blurImage(img);
  }
  if (key == 'g' || key == 'G') {
    grayscaleImage(img);
  }
  if (key == 't' || key == 'T') {
    thresholdImage(img, 0.5);
  }
  if (key == 'r' || key == 'R') {
    img = originalImg.copy();  // Reset to the original image
  }
}