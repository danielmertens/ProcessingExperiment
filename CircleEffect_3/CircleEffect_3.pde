int step;
int centerX;
int centerY;
int colorLimit;
int speed;
int[] circles;
int resetValue;
int min = 57;

int[][][] pixels;

void setup() {
  size(600, 600);
  speed = 4;
  step = 6;
  colorLimit = 50;
  centerX = width / 2;
  centerY = height / 2;
  circles = new int[3];
  circles[0] = 0;
  circles[1] = - colorLimit * 2;
  circles[2] = - colorLimit * 4;
  resetValue = (int) sqrt(pow(0 - centerX, 2) + pow(0 - centerY, 2)) + colorLimit*10;
  
  pixels = new int[width/step][height/step][3];
  
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
  for(int x = 0; x < pixels.length; x++) {
    for(int y = 0; y < pixels[x].length; y++) {
      //fill(180,255,180,255);
      //rect(x - step / 2,y - step / 2,step,step);
      
      //int alpha = 255;
      boolean found = false;
      for(int r = 0; r < circles.length && circles[r] >=0 && !found ; r++) {
        int distance = (int) abs(sqrt(pow(x*step - centerX, 2) + pow(y*step - centerY, 2)) - circles[r]);
        if(distance < step) {
          pixels[x][y][0] = 255;
          float rand = randomGaussian() * 100 - 25;
          pixels[x][y][1] = (int) (rand < 10 ? 10 : rand);
          pixels[x][y][2] = 255;
          
          found = true;
        }
      }
      if(!found) {
        if(pixels[x][y][2] != 0) {
          int newAlpha = pixels[x][y][2] - pixels[x][y][1];
          //pixels[x][y][1] *= 2;
          pixels[x][y][2] = newAlpha < 0 ? 0 : newAlpha;
        }
        pixels[x][y][0] = pixels[x][y][0] - 10 > 160 ? pixels[x][y][0] - 10 : pixels[x][y][0];
      }
      fill(255 - pixels[x][y][0], pixels[x][y][0], 255 - pixels[x][y][0], pixels[x][y][2]);
      rect(x*step - step / 2,y*step - step / 2,step,step);
    }
  }
  
  for(int r = 0; r < circles.length; r++) {
    circles[r] += speed;
    if(circles[r] > resetValue)
      circles[r] = 0;
  }
}
