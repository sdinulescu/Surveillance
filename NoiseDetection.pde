//https://forum.processing.org/two/discussion/855/how-can-i-make-full-screen-with-capture-cam
//Using above for reference

import processing.video.*; //video import statements
import processing.sound.*; //sound import statements

Capture video;
PinkNoise noisePink;

int numPixels;
int[] previousFrame;

void setup()  {  
  fullScreen(); 
  video = new Capture(this, width, height);
  video.start();
  
  noisePink = new PinkNoise(this);
  noisePink.play();
  
  numPixels = video.width * video.height; //stores total number of pixels
  previousFrame = new int[numPixels]; //stores previously captured frame
  loadPixels(); //loads pixels for use
}   


void draw()  
{  
  set(0, 0, video); //sets video
  if (video.available())  
  {  
    video.read(); //reads video
    video.loadPixels(); //loads pixels
    int movementSum = 0; // Amount of movement in the frame
    for (int i = 0; i < numPixels; i++) { // goes through number of pixels in video
      color currColor = video.pixels[i];
      //Red, green, and blue components from current pixel
      int currR = (int)red(pixels[i]);
      int currG = (int)green(pixels[i]);
      int currB = (int)blue(pixels[i]);
      //Red, green, and blue components from previous pixel
      int prevR = (int)red(previousFrame[i]);
      int prevG = (int)green(previousFrame[i]);
      int prevB = (int)blue(previousFrame[i]);
      //Difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      movementSum += diffR + diffG + diffB;
      pixels[i] = color(diffR, diffG, diffB);
      previousFrame[i] = currColor;
    }
    delay(5000);
    if (movementSum > 0) {
      updatePixels();
    }
  }   
}