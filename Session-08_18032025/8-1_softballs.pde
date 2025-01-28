int numShapes = 50;
float[] x = new float[numShapes];
float[] y = new float[numShapes];
float[] noiseOffsets = new float[numShapes];

void setup() {
  size(600, 600);
  for (int i = 0; i < numShapes; i++) {
    x[i] = random(width);
    y[i] = random(height);
    noiseOffsets[i] = random(100);
  }
  noStroke();
}

void draw() {
  background(20, 20, 50, 20); // Transparent background for fading effect
  for (int i = 0; i < numShapes; i++) {
    float n = noise(noiseOffsets[i]);
    fill(lerpColor(color(255, 100, 150), color(100, 200, 255), n));
    float size = map(n, 0, 1, 10, 50);
    ellipse(x[i] + sin(frameCount * 0.01 + i) * 50, 
            y[i] + cos(frameCount * 0.01 + i) * 50, size, size);
    noiseOffsets[i] += 0.01;
  }
}

void mousePressed() {
  for (int i = 0; i < numShapes; i++) {
    x[i] = random(width);
    y[i] = random(height);
  }
}