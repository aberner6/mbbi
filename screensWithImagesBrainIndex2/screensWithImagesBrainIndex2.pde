//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}

PFont font;
int fontSize = 12;

Line [] lines;

int cx, cy;

boolean d, n, u, p, t = false;

int thiswidth= 1200; //(1440 x 900)
int thisheight = 515; //1920 x 1080

PImage img;
PImage img2; 

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 60;
int screenHeight = 140;
int whichScreen;
int topMargin = 0;
int screenCount = 12;
int lmargin = 10;

void setup() {
  size(thiswidth-115, thisheight+screenHeight); //size(1500, 750); //100

  colorMode(HSB, 360, 100, 100);
  fill (300);

  smooth();
  
  lines = new Line[screenCount]; 
  parse();

  img = loadImage("brainimg.png");  // Load the image into the program  
  img2 = loadImage("bluegrid.jpg");  // Load the other image into the program  

}

void parse(){
    for (int i = 0; i< screenCount; i++) {
        Line line = new Line();
        lines[i]=line;
    }
}

void draw() {
  background(360);
  image(img, 0, 0, img.width*2/3, img.height*2/3);
  for (int i = 0; i< screenCount; i++) {
      lines[i].update();
      lines[i].render();
    }
  if (d) {
    floatDown();
  }
  if (p) {
    floatPrep();
  }
  if (u) {
    floatUp();
  }
}
void floatPrep() {
  for (int i = 0; i< screenCount; i++) {
    if (lines[i] != null) {
      float screenX = map(i, 0, screenCount-1, lmargin, width); 
      lines[i].cx = screenX;
      lines[i].cy = 0; 
      lines[i].tpos.x = 0;
      lines[i].tpos.y = 0;
    }
  }
}
void floatDown() {
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null){
      float screenX = map(i, 0, screenCount-1, lmargin, width); 
      lines[i].cx = screenX;
      lines[i].cy = 0; 
      lines[i].pos.x = 0;
      lines[i].pos.y = 0;

      lines[i].tpos.x = 0;
      lines[i].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatUp() {
  for (int i = 0; i< screenCount; i++) {
      if (u) {
        lines[6].tpos.y = height/2;
        lines[7].tpos.y = height/3;
      }
      if (t) {
        lines[6].tpos.y = height-screenHeight+topMargin;
        lines[7].tpos.y = height-screenHeight+topMargin;
      }
  }
}

void keyPressed() {
  if (key=='d') d = !d; 
  if (key=='u') u = !u;
  if (key=='n') n = !n;
  if (key=='p') p = !p;
  if (key=='t') t = !t;
}
