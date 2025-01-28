float angleStep = 15;
float baseRadius = 50;

void setup() {
  size(600, 600);
  noCursor();
  frameRate(30);
}

void draw() {
  background(20);
  translate(width / 2, height / 2);
  float time = millis() * 0.001;

  for (float angle = 0; angle < 360; angle += angleStep) {
    pushMatrix();
    rotate(radians(angle));
    float dynamicRadius = baseRadius + mouseY / 10 + sin(time + angle) * 20;
    float x = cos(time) * dynamicRadius;
    float y = sin(time) * dynamicRadius;

    for (int i = 0; i < 6; i++) {
      pushMatrix();
      rotate(radians(60 * i));
      float size = map(mouseX, 0, width, 10, 50);
      fill((angle * 2 + frameCount) % 255, 150, 200);
      noStroke();
      ellipse(x, y, size, size);
      popMatrix();
    }
    popMatrix();
  }
}

void keyPressed() {
  if (key == '1') angleStep = 10;
  if (key == '2') angleStep = 20;
  if (key == '3') angleStep = 30;
}