// Minimalistic Fractal Line Art with Randomized Shapes

void setup() {
  size(800, 800);
  background(255); // White background for a clean minimalistic look
  stroke(0); // Black lines for simplicity
  noFill();
  
  translate(width / 2, height); // Start at the bottom center of the canvas
  drawFractalTree(200, PI / 2, 8); // Initial length, angle, and depth
}

void drawFractalTree(float length, float angle, int depth) {
  if (depth == 0) return; // Base case: stop recursion when depth is zero
  
  // Draw the main branch
  float x2 = cos(angle) * length;
  float y2 = -sin(angle) * length;
  line(0, 0, x2, y2);
  
  // Move to the end of the branch
  translate(x2, y2);
  
  // Randomize branching behavior
  int branches = int(random(2, 4)); // Random number of branches (2 or 3)
  
  for (int i = 0; i < branches; i++) {
    pushMatrix();
    float randomAngle = angle + random(-PI / 4, PI / 4); // Randomize angle within ±45°
    float randomLength = length * random(0.5, 0.8); // Randomize branch length
    drawFractalTree(randomLength, randomAngle, depth - 1); // Recursive call with randomized parameters
    popMatrix();
  }
}