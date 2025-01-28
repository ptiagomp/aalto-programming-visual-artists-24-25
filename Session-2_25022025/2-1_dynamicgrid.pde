void setup() {
  size(400, 400);
  noLoop();
}

void draw() {
  background(220);
  int gridSize = 40;
  for (int x = 0; x < width; x += gridSize) {
    for (int y = 0; y < height; y += gridSize) {
      fill(random(255), random(255), random(255));
      rect(x, y, gridSize - 5, gridSize - 5);
    }
  }
}