import processing.video.*;

Capture video;

PImage previousFrame;

float threshold = 50;

float motX = 0;
float motY = 0;

float lerpX = 0;
float lerpY = 0;

  void setup(){
  size(640, 360);
  String[] cams = Capture.list();
  printArray(cams);
  video = new Capture(this, cams[0]);
  video.start();
  previousFrame = createImage(video.width, video.height, RGB);
  
}

  void captureEvent(Capture video){
    
    previousFrame.copy(video, 0, 0, video.width, video.height, 0, 0, previousFrame.width, previousFrame.height);
    previousFrame.updatePixels();
    video.read();
}

void draw() {
  video.loadPixels();
  previousFrame.loadPixels();
  image(video, 0, 0);
  
  int count = 0;
  float avgX = 0;
  float avgY = 0;



  loadPixels();
  
  int videoWidth = video.width;
  int videoHeight = video.height;
  
  for (int x = 0; x < videoWidth; x++) {
    for (int y = 0; y < videoHeight; y++) {
      int index = x + y * videoWidth;

      // Check if index is within the bounds of the pixels array
      if (index >= 0 && index < pixels.length) {
        color curCol = video.pixels[index];
        
        float r1 = red(curCol);
        float g1 = green(curCol);
        float b1 = blue(curCol);
        
        color previousCol = previousFrame.pixels[index];
        float r2 = red(previousCol);
        float g2 = green(previousCol);
        float b2 = blue(previousCol);
        
        float dist = euclideanDist(r1, g1, b1, r2, g2, b2);
        
        if (dist > threshold * threshold) {
          avgX += x;
          avgY += y;
          count++;
          pixels[index] = color(255);
        } else {
          pixels[index] = color(0);
        }
      }
    }
  }
  updatePixels();
  
  if(count > 150){
    motX = avgX / count;
    motY = avgY / count;
  }
  lerpX = lerp(lerpX, motX, 0.2);
  lerpY = lerp(lerpY, motY, 0.2);
  fill(128, 0, 44);
  strokeWeight(2.0);
  stroke(0);
  ellipse(lerpX, lerpY, 24, 24);
}
  float euclideanDist(float x1, float y1, float z1, float x2, float y2, float z2){
  
    float dist = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
    return dist;
  }
