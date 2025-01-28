Ball[] balls = new Ball[10];

void setup() {
  size(400, 400);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(random(width), random(height), random(2, 5), random(2, 5));
  }
}

void draw() {
  background(220);
  for (Ball b : balls) {
    b.move();
    b.display();
  }
}

class Ball {
  float x, y, xSpeed, ySpeed;
  
  Ball(float x, float y, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
  
  void move() {
    x += xSpeed;
    y += ySpeed;
    if (x < 0 || x > width) xSpeed *= -1;
    if (y < 0 || y > height) ySpeed *= -1;
  }
  
  void display() {
    fill(100, 150, 255);
    ellipse(x, y, 20, 20);
  }
}