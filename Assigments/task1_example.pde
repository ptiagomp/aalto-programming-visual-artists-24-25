// Setup your workspace and canvas
void setup() {
  size(800, 600);          // Set canvas size to 800x600 pixels
  noStroke();              // Disable shape outlines
}

// Continuously update the screen
void draw() {
  background(30, 30, 30);  // Set a dark background
  
  // Map mouseX and mouseY to color ranges
  float redValue = map(mouseX, 0, width, 0, 255);
  float greenValue = map(mouseY, 0, height, 0, 255);
  float blueValue = map(mouseX + mouseY, 0, width + height, 255, 0);

  // Draw a circle that follows the mouse with dynamic color
  fill(redValue, greenValue, blueValue);
  ellipse(mouseX, mouseY, 100, 100);

  // Draw a rectangle that changes size based on mouse position
  float rectWidth = map(mouseX, 0, width, 50, 300);
  float rectHeight = map(mouseY, 0, height, 50, 200);
  fill(blueValue, redValue, greenValue);
  rect(width / 4, height / 4, rectWidth, rectHeight);

  // Add an animated polygon that moves based on the mouse coordinates
  fill(greenValue, blueValue, redValue);
  drawPolygon(mouseX, mouseY, 60, 6);  // Hexagon centered at the mouse
}

// Helper function to draw a polygon
void drawPolygon(float x, float y, float radius, int sides) {
  beginShape();
  for (int i = 0; i < sides; i++) {
    float angle = TWO_PI / sides * i;
    float px = x + cos(angle) * radius;
    float py = y + sin(angle) * radius;
    vertex(px, py);
  }
  endShape(CLOSE);
}