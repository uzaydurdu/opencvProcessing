import processing.video.*;

Capture video;

float threshold = 30;
color trackColor;

  void setup(){
  size(680, 400);
  String[] cams = Capture.list();
  printArray(cams);
  video = new Capture(this, cams[0]);
  video.start();
  
  trackColor = color(0,0, 255);
}

  void captureEvent(Capture video){
  video.read();
}

  void draw(){
  video.loadPixels();
  image(video, 0, 0);
  
  float avgX = 0;
  float avgY = 0;
  
  int count = 0;
  
  for(int x=0; x<video.width; x++){
    for(int y=0; y<video.height; y++){
      int index = x + y * video.width;
      
      color curCol = video.pixels[index];
      
      float r1 = red(curCol);
      float g1 = green(curCol);
      float b1 = blue(curCol);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      
      float dist = euclideanDist(r1, g1, b1, r2, g2, b2);
      
      if(dist < threshold*threshold){
        avgX += x;
        avgY += y;
        count++;
      }
      }
    }
  if(count > 0){
        avgX = avgX / count;
        avgY = avgY / count;
        
        fill(trackColor);
        strokeWeight(4.0);
        stroke(0);
        ellipse(avgX, avgY, 24, 24);
  }
}

  void mousePressed(){
    int pixIndex = mouseX + mouseY * video.width;
    trackColor = video.pixels[pixIndex];
  }
  
  float euclideanDist(float x1, float y1, float z1, float x2, float y2, float z2){
  
    float dist = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
    return dist;
  }
