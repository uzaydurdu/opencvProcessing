class Blob{
  
  float minX, minY, maxX, maxY;

  
  Blob(float x, float y){
    minX = x;
    minY = y;
    maxX = x;
    maxY = y;
  }
  
  void show(){
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minX, minY, maxX, maxY);
  }
  
  void add(float px, float py){
    minX = min(minX, px);
    minY = min(minY, py);
    maxX = max(maxX, px);
    maxY = max(maxY, py);
  }
  
  float area(){
    return (maxX-minX)*(maxY-minY);
  }
  
  
  boolean isNear(float px, float py){
    
    float cx = (minX + maxX) / 2;
    float cy = (minY + maxY) / 2;
    float dist = euclideanDist(cx, cy, px, py);
    
    if(dist < distThreshold*distThreshold){
      return true;
    }
    else{
      return false;
    }
  }
  
}
