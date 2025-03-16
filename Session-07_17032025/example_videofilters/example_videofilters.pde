import processing.video.*;

Movie video;
boolean invertEffect = false;
boolean grayscaleEffect = false;
boolean thresholdEffect = false;
boolean blurEffect = false;

void setup() {
  size(800, 600);
  video = new Movie(this, "test.mp4");  // Load the video file into data folder of your sketch
  video.loop();  // Start looping the video forever
}

void draw() {
  background(0);

  if (video.available()) {
    video.read();  // Read the next frame
    video.loadPixels();  // Ensure we can manipulate pixels
  }

  if (video.width > 0 && video.height > 0) {  // Ensure video has loaded
    PImage frame = video.get(); // Get the current frame as an image
    frame.resize(width, height); // Resize the video to match canvas size

    // Apply selected effects
    if (invertEffect) {
      invertVideo(frame);
    }
    if (grayscaleEffect) {
      grayscaleVideo(frame);
    }
    if (thresholdEffect) {
      thresholdVideo(frame, 0.5);
    }
    if (blurEffect) {
      frame.filter(BLUR, 6);
    }

    image(frame, 0, 0); // Display the processed video frame
  }
}

// This function is called whenever the movie reaches the end
void movieEvent(Movie m) {
  m.read();
  if (m.time() >= m.duration() - 0.1) { // Check if video is at the end
    m.jump(0); // Restart from the beginning
    m.play(); // Ensure it starts playing again
  }
}

void invertVideo(PImage img) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    img.pixels[i] = color(255 - red(c), 255 - green(c), 255 - blue(c));
  }
  img.updatePixels();
}

void grayscaleVideo(PImage img) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float avg = (red(c) + green(c) + blue(c)) / 3;
    img.pixels[i] = color(avg, avg, avg);
  }
  img.updatePixels();
}

void thresholdVideo(PImage img, float threshold) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float brightness = (red(c) + green(c) + blue(c)) / 3;
    img.pixels[i] = brightness > threshold * 255 ? color(255) : color(0);
  }
  img.updatePixels();
}

void keyPressed() {
  if (key == 'i' || key == 'I') {
    invertEffect = !invertEffect;
    println("Invert!");
  }
  if (key == 'b' || key == 'B') {
    blurEffect = !blurEffect;
    println("Blur!");
  }
  if (key == 'g' || key == 'G') {
    grayscaleEffect = !grayscaleEffect;
    println("Gray!");
  }
  if (key == 't' || key == 'T') {
    thresholdEffect = !thresholdEffect;
    println("Treshold!");
  }
}