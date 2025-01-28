#include <NewPing.h>

const int trigPin = 9;
const int echoPin = 10;
const int redPin = 3;
const int greenPin = 5;
const int bluePin = 6;

NewPing sonar(trigPin, echoPin, 200);  // Pin and max distance (in cm)

void setup() {
  Serial.begin(9600);
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
}

void loop() {
  delay(50);  // Small delay to avoid overload

  int distance = sonar.ping_cm();  // Measure the distance in cm
  Serial.println(distance);         // For debugging

  // Map the distance to LED color values (distance close = red, far = blue)
  if (distance > 0) {
    int redValue = map(distance, 0, 200, 255, 0);
    int greenValue = map(distance, 0, 200, 0, 255);
    int blueValue = map(distance, 0, 200, 0, 255);

    analogWrite(redPin, redValue);
    analogWrite(greenPin, greenValue);
    analogWrite(bluePin, blueValue);
  }
}