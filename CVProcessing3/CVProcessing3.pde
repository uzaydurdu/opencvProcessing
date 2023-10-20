import processing.video.*;

Capture video;

float threshold = 30;
  float distThreshold = 25;
color trackColor;

ArrayList<Blob> blobs = new ArrayList<Blob>();

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
  
  blobs.clear();
  
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
        
         boolean isFound = false;
         
         for(Blob b : blobs){
           if(b.isNear(x,y)){
             b.add(x,y);
             isFound = true;
             break;
           }
         }
         
         if(!isFound){
            Blob b = new Blob(x,y);
            blobs.add(b);
         }
      }
      }
    }
  for(Blob b : blobs){
    if(b.area() > 100){
    
    }
    b.show();      
  }
}

  void mousePressed(){
    int pixIndex = mouseX + mouseY * video.width;
    trackColor = video.pixels[pixIndex];
  }
  
   float euclideanDist(float x1, float y1, float x2, float y2){
  
    float dist = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
    return dist;
  }
  
  float euclideanDist(float x1, float y1, float z1, float x2, float y2, float z2){
  
    float dist = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
    return dist;
  }
  
  void keyPressed(){
    if(key == 'a'){
      distThreshold++;
    }
    else if(key == 'z' &&  distThreshold > 0){
      distThreshold--;
    }
  }
