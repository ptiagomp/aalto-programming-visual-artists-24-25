import processing.sound.*;

Amplitude amp;
AudioIn in;

float[] amplitudes = new float[50];
int index = 0;

void setup() {
  size(800, 600);
  background(0);

  // Setup audio input
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw() {
  background(0, 20); // Add a fade effect to trails
  
  float currentAmp = amp.analyze() * 100;
  amplitudes[index] = currentAmp;
  index = (index + 1) % amplitudes.length;

  translate(width / 2, height / 2);
  noFill();
  strokeWeight(2);

  // Draw frequency-based circles
  for (int i = 0; i < amplitudes.length; i++) {
    float size = amplitudes[i] * 10;
    stroke(lerpColor(color(100, 200, 255), color(255, 100, 150), (float) i / amplitudes.length));
    ellipse(0, 0, size, size);
  }

  // Rotating polygon with amplitude
  pushMatrix();
  rotate(frameCount * 0.01);
  stroke(255, 100, 150);
  strokeWeight(4);
  for (int i = 0; i < 6; i++) {
    float radius = map(currentAmp, 0, 100, 50, 300);
    float x = cos(TWO_PI / 6 * i) * radius;
    float y = sin(TWO_PI / 6 * i) * radius;
    line(0, 0, x, y);
  }
  popMatrix();
}