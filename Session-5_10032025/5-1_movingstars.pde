int numStars = 50;
float[] starX = new float[numStars];
float[] starY = new float[numStars];

void setup() {
  size(400, 400);
  for (int i = 0; i < numStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
  }
}

void draw() {
  background(0);
  fill(255, 255, 100);
  noStroke();
  
  for (int i = 0; i < numStars; i++) {
    ellipse(starX[i], starY[i], 5, 5);
    starY[i] += 1;
    if (starY[i] > height) {
      starY[i] = 0;
    }
  }
}
