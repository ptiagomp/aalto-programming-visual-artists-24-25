// Import Minim library for audio playback and analysis
import ddf.minim.*;
import ddf.minim.analysis.*;

// Declare Minim, AudioPlayer, and FFT objects
Minim minim;
AudioPlayer player;
FFT fft;

// Define the number of frequency bands for visualization
int bands = 64; // More bands = more detailed spectrum
float[] spectrum; // Array to store FFT values

void setup() {
  size(800, 400); // Set window size
  
  // Initialize Minim audio library
  minim = new Minim(this);
  
  // Load and play an audio file (ensure "sample.mp3" is in the sketch folder)
  player = minim.loadFile("sample.mp3", 1024);
  player.play();
  
  // Set up FFT analysis
  // FFT buffer size must match the player's buffer size
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  // Logarithmic frequency scale for better visualization
  fft.logAverages(22, 3); // (min bandwidth, bands per octave)
  
  // Initialize spectrum array
  spectrum = new float[bands];
}

void draw() {
  background(0); // Clear the screen
  
  // Perform FFT on the mixed audio signal (stereo combined)
  fft.forward(player.mix);
  
  // Draw the frequency spectrum as bars
  for (int i = 0; i < bands; i++) {
    // Store the amplitude of each frequency band
    spectrum[i] = fft.getBand(i);
    
    // Map the frequency band index to screen width
    float x = map(i, 0, bands, 50, width - 50);
    
    // Map the amplitude to a suitable height for visualization
    float h = map(spectrum[i], 0, 100, 2, height - 50);
    
    // Set color of the bars (green)
    fill(0, 255, 100);
    
    // Draw each frequency bar as a rectangle
    rect(x, height - h, width / bands - 2, h);
  }
}

// Stop the audio and free resources when the sketch exits
void stop() {
  player.close();
  minim.stop();
  super.stop();
}