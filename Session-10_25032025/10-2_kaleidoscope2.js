let cam;
let prevFrame;
let motionMask;

let segments = 6;    // Number of kaleidoscopic segments
let threshold = 25;  // Brightness difference threshold
let angleStep;

function setup() {
  createCanvas(640, 480);
  frameRate(30);

  // Initialize camera
  cam = createCapture(VIDEO);
  cam.size(width, height);
  cam.hide(); // Hide the HTML video element

  // Create storage images for previous frame and motion mask
  prevFrame = createImage(width, height);
  motionMask = createImage(width, height);

  // Use HSB color mode so brightness() works as expected
  colorMode(HSB, 255);
}

function draw() {
  // Make sure the camera is working with fresh pixel data
  cam.loadPixels();
  
  // If we have not yet stored anything in prevFrame (first frame), do it now
  if (prevFrame.width === 0 || prevFrame.height === 0) {
    prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
    return;
  }

  // 1) Build a mask of only the pixels that moved
  detectMotion();

  // 2) Draw the kaleidoscope using motionMask
  background(0);
  translate(width / 2, height / 2);

  angleStep = 360 / segments;
  for (let i = 0; i < segments; i++) {
    push();
    rotate(radians(angleStep * i));

    // Optionally flip every other segment for a mirror effect
    // if (i % 2 === 0) scale(-1, 1);

    imageMode(CENTER);
    // Draw motionMask once per segment
    image(motionMask, 0, 0, width, height);
    pop();
  }

  // 3) Save current frame as the previous frame for the next iteration
  prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
}

// --------------------------------------------------------
// DETECT MOTION + BUILD MOTION MASK
// --------------------------------------------------------
function detectMotion() {
  // Load pixel arrays for reading/manipulating
  prevFrame.loadPixels();
  motionMask.loadPixels();

  // cam.pixels, prevFrame.pixels, and motionMask.pixels each have 4 entries per pixel (RGBA)
  for (let i = 0; i < cam.pixels.length; i += 4) {
    // Current frame's color
    let r1 = cam.pixels[i + 0];
    let g1 = cam.pixels[i + 1];
    let b1 = cam.pixels[i + 2];

    // Previous frame's color
    let r2 = prevFrame.pixels[i + 0];
    let g2 = prevFrame.pixels[i + 1];
    let b2 = prevFrame.pixels[i + 2];

    // Convert both colors to HSB to use p5's brightness() function
    let currentB = brightness(color(r1, g1, b1));
    let previousB = brightness(color(r2, g2, b2));
    let diff = abs(currentB - previousB);

    // If difference > threshold, we keep the pixel; otherwise, transparent
    if (diff > threshold) {
      motionMask.pixels[i + 0] = r1;  // R
      motionMask.pixels[i + 1] = g1;  // G
      motionMask.pixels[i + 2] = b1;  // B
      motionMask.pixels[i + 3] = 255; // A (fully opaque)
    } else {
      // Make it fully transparent (no movement)
      motionMask.pixels[i + 0] = 0;
      motionMask.pixels[i + 1] = 0;
      motionMask.pixels[i + 2] = 0;
      motionMask.pixels[i + 3] = 0;
    }
  }

  // Finalize updates to motionMask
  motionMask.updatePixels();
}

// --------------------------------------------------------
// OPTIONAL KEY CONTROLS
// --------------------------------------------------------
function keyPressed() {
  if (key === '+') {
    threshold++;
    print("Threshold:", threshold);
  } else if (key === '-' && threshold > 0) {
    threshold--;
    print("Threshold:", threshold);
  }

  // Increase or decrease kaleidoscope segments
  if (key === 's') {
    segments = max(1, segments - 1);
    print("Segments:", segments);
  } else if (key === 'S') {
    segments++;
    print("Segments:", segments);
  }
}