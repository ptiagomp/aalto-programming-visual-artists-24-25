float x = 200, y = 0;
float basketX = 200;
float speed = 2;
int score = 0;

void setup() {
  size(400, 400);
}

void draw() {
  background(220);
  // Draw falling object
  ellipse(x, y, 20, 20);
  y += speed;

  // Draw basket
  rect(basketX, height - 20, 50, 10);

  // Check for catch
  if (y > height - 30 && x > basketX && x < basketX + 50) {
    y = 0;
    x = random(width);
    score++;
  } else if (y > height) {
    y = 0;
    x = random(width);
  }

  // Display score
  textSize(16);
  fill(0);
  text("Score: " + score, 10, 20);
}

void keyPressed() {
  if (keyCode == LEFT) basketX -= 20;
  if (keyCode == RIGHT) basketX += 20;
}