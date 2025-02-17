// Dynamic Circle Grid with Mouse Interaction

void setup() {
  // Set up the canvas size
  size(800, 600);
  noStroke(); // Disable outlines for the circles
}

void draw() {
  background(30); // Set a dark background for contrast

  int cols = 10; // Number of columns in the grid
  int rows = 8;  // Number of rows in the grid
  float circleSpacing = width / cols; // Spacing between circles horizontally
  float circleSize = map(mouseX, 0, width, 10, 80); // Circle size changes with mouseX
  float colorShift = map(mouseY, 0, height, 0, 255); // Color changes based on mouseY

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Calculate circle position in the grid
      float x = i * circleSpacing + circleSpacing / 2;
      float y = j * circleSpacing + circleSpacing / 2;

      // Calculate distance from mouse to each circle
      float distToMouse = dist(mouseX, mouseY, x, y);

      // Modify circle size based on proximity to mouse
      float dynamicSize = map(distToMouse, 0, width / 2, circleSize * 1.5, circleSize / 2);
      dynamicSize = constrain(dynamicSize, 5, circleSize * 1.5); // Constrain size to avoid extremes

      // Set fill color based on proximity and mouseY position
      fill((colorShift + i * j) % 255, (255 - colorShift + i * j) % 255, (distToMouse / width) * 255);

      // Draw the circle
      ellipse(x, y, dynamicSize, dynamicSize);
    }
  }
}