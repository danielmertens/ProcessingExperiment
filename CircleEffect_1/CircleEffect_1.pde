int step;
int centerX;
int centerY;
color white = color(255,255,255);
int colorLimit;
int speed;
int[] circles;
int resetValue;
int min = 57;

void setup() {
  size(600, 600);
  speed = 4;
  step = 10;
  colorLimit = 50;
  centerX = width / 2;
  centerY = height / 2;
  circles = new int[3];
  circles[0] = 0;
  circles[1] = - colorLimit * 2;
  circles[2] = - colorLimit * 4;
  resetValue = (int) sqrt(pow(0 - centerX, 2) + pow(0 - centerY, 2)) + colorLimit*10;
}

void draw() {
  background(255);
  noStroke();
  // For syncing
  //if(minute() < min) {
  //  if(minute()  > min - 1) {
  //    println(second());
  //  }
  //  return;
  //}
  for(int x = 0; x < width + step; x+= step) {
    for(int y = 0; y < height + step; y += step) {
      color c = white;
      boolean found = false;
      for(int r = 0; r < circles.length && circles[r] >=0 && !found ; r++) {
        //int distance = (int) abs(sqrt(pow(x - centerX, 2) + pow(y - centerY, 2)) - circles[r]);
        int distance = (int) sqrt(pow(x - centerX, 2) + pow(y - centerY, 2)) - circles[r];
        if(distance < 0 && distance > - colorLimit) {
          //int green = 255 - (255 / colorLimit) * distance;
          int green = 255 - (150 / colorLimit) * (- distance);
          c = color(0,green,0);
          found = true;
        }
      }
      fill(c);
      rect(x - step / 2,y - step / 2,step,step);
    }
  }
  
  for(int r = 0; r < circles.length; r++) {
    circles[r] += speed;
    if(circles[r] > resetValue)
      circles[r] = 0;
  }
  
  //println(circles[0] + "|" + circles[1] + "|" + circles[2]);
}
