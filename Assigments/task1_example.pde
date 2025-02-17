// Interactive Sketch: Mouse Movement-based Color and Shape

void setup() {
  // Set up the canvas size
  size(800, 600);
  // Disable outlines for shapes
  noStroke();
}

void draw() {
  // Background color changes dynamically based on mouseX and mouseY
  background(mouseX / 3, mouseY / 2, (mouseX + mouseY) / 4);

  // Draw a circle that follows the mouse
  fill(mouseY % 255, mouseX % 255, (mouseX + mouseY) % 255); // Dynamic color based on mouse position
  ellipse(mouseX, mouseY, 50, 50); // Circle's position is tied to the mouse

  // Draw a rectangle that moves inversely to the mouse
  fill((255 - mouseX) % 255, (255 - mouseY) % 255, (mouseX * mouseY) % 255);
  rect(width - mouseX, height - mouseY, 100, 50);

  // Draw a dynamic grid of small squares that change colors with the mouse
  for (int i = 0; i < width; i += 50) {
    for (int j = 0; j < height; j += 50) {
      fill((i + mouseX) % 255, (j + mouseY) % 255, (i + j + mouseX + mouseY) % 255);
      rect(i, j, 40, 40);
    }
  }

  // Add a triangle that rotates based on the X position of the mouse
  pushMatrix(); // Save current transformation state
  translate(width / 2, height / 2); // Move to center of canvas
  rotate(radians(mouseX % 360)); // Rotate based on mouseX
  fill((mouseX * mouseY) % 255, (mouseY * mouseX) % 255, (mouseX + mouseY) % 200);
  triangle(-50, -50, 50, -50, 0, 100); // Draw triangle
  popMatrix(); // Restore original transformation state
}