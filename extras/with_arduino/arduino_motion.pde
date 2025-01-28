import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;         // Data received from the serial port
int distance;

void setup() {
  size(640, 480);
  println(Serial.list());  // List all available serial ports
  myPort = new Serial(this, Serial.list()[0], 9600);  // Connect to Arduino
  myPort.bufferUntil('\n');  // Buffer until newline character is received
}

void draw() {
  background(0);

  // Map the incoming distance to screen size
  float mappedDistance = map(distance, 0, 200, 0, width);

  // Display the distance
  fill(255);
  textSize(32);
  text("Distance: " + distance + " cm", 10, height - 30);

  // Create a gradient effect based on distance
  fill(mappedDistance, 255 - mappedDistance, mappedDistance / 2);
  ellipse(width / 2, height / 2, mappedDistance, mappedDistance);

}

void serialEvent(Serial myPort) {
  String inData = myPort.readStringUntil('\n');  // Read the incoming data
  if (inData != null) {
    inData = trim(inData);  // Remove any trailing whitespace
    distance = int(inData); // Convert the string to an integer
  }
}