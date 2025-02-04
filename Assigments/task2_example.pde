void setup() {
  // Set up the canvas size to 800x800 pixels
  size(800, 800);
  
  // Disable the outline around shapes
  noStroke();
}

void draw() {
  // Clear the background with a white color on every frame
  background(255);

  // Define the number of columns and rows in the grid
  int cols = 10;
  int rows = 10;

  // Calculate the circle size based on the horizontal mouse position
  // The size will range from 10 to 100 pixels
  float circleSize = map(mouseX, 0, width, 10, 100);

  // Loop through each column (i) and each row (j) to create the grid
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Calculate the x and y position for each circle
      // Circles are spaced evenly across the canvas
      float x = i * (width / cols) + (width / cols) / 2;
      float y = j * (height / rows) + (height / rows) / 2;

      // Calculate the color dynamically based on the vertical mouse position
      // The red component increases as the mouse moves down the screen
      float r = map(mouseY, 0, height, 0, 255);
      
      // Set the fill color for the circle using the calculated red value
      // Green is fixed at 100, and blue decreases as red increases
      fill(r, 100, 255 - r);

      // Draw the circle at the calculated position with the dynamic size
      ellipse(x, y, circleSize, circleSize);
    }
  }
}