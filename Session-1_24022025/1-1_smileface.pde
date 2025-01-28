void setup() {
  size(400, 400);
  background(200, 220, 255);
  // Face
  fill(255, 220, 200);
  ellipse(200, 200, 200, 200);
  // Eyes
  fill(0);
  ellipse(170, 180, 20, 20);
  ellipse(230, 180, 20, 20);
  // Mouth
  noFill();
  stroke(0);
  strokeWeight(3);
  arc(200, 220, 100, 50, 0, PI);
}
