void setup() {
  size(400, 400);
}

void draw() {
  background(220);
  drawFace(mouseX, mouseY, 50);
}

void drawFace(float x, float y, float size) {
  fill(255, 220, 200);
  ellipse(x, y, size, size);
  fill(0);
  ellipse(x - size / 4, y - size / 6, size / 6, size / 6);
  ellipse(x + size / 4, y - size / 6, size / 6, size / 6);
  noFill();
  stroke(0);
  arc(x, y + size / 6, size / 2, size / 3, 0, PI);
}
