//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}
int fadeTime = 0;
int duration = 4000; // Dauer des Fades in Millisekunden
PImage images[];
PImage newImages[];
int index;


PFont font;
int fontSize = 12;

Line [] lines;

int cx, cy;
//int index = 1;
boolean one, two, three, four, five, six, seven, eight, nine, ten, zero = false;
boolean prep, floatMedium = false;

int thiswidth= 1200; //(1440 x 900)
int thisheight = 515; //1920 x 1080

PImage background;
PImage img;
PImage img2; 
PImage img3;

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 60;
int screenHeight = 140;
int whichScreen;
int topMargin = 0;
int screenCount = 12;
int lmargin = 10;

int m = 0;
int indie = 1;

void setup() {
  size(thiswidth-115, thisheight+screenHeight); //size(1500, 750); //100

  colorMode(HSB, 360, 100, 100);
  fill (300);

  smooth();

  lines = new Line[screenCount]; 
  parse();
  
  
  images = new PImage[5];
  newImages = new PImage[5];
  background = loadImage( "background.jpg" );

//  images[0] = loadImage( "background.jpg" );
  for(int t=1;t<5;t++){
    images[t] = loadImage( "" + t + ".jpg" );
    
newImages[t] = images[t].get(0,0,screenWidth,screenHeight);    
    
  };  
//background.resize(screenWidth, 0);
  
//  img = loadImage("brainimg.png");  // Load the image into the program  
//  img2 = loadImage("bluegrid.jpg");  // Load the other image into the program  
//  img3 = loadImage("screen1.png");
}

void parse() {
  for (int i = 0; i< screenCount; i++) {
    Line line = new Line();
    lines[i]=line;
  }
}

void draw() {
  background(360);
  image(background, 0, 0, background.width*2/3, background.height*2/3);
  for (int i = 0; i< screenCount; i++) {
    lines[i].update();
    lines[i].render();
  }
  if (zero) {
    floatZero();
  }
  if (one) {
    floatOne();
  }
  if (two) {
    floatTwo();
  }
  if (three) {
    floatThree();
  }
  if (four) {
    floatFour();
  }
  if (five) {
    floatFive();
  }
  if (six) {
    floatSix();
  }
  if (seven) {
    floatSeven();
  }
  if (eight) {
    floatEight();
  }
  if (nine) {
    floatNine();
  }
  if (eight) {
    floatTen();
  }
  if (prep) {
    floatPrep();
  }
  if (floatMedium) {
    floatMedium();
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
      lines[i].opacity = 255;
    }
  }
}
void floatOne() {
  int whichScreen = 1;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatTwo() {
  int whichScreen = 2;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatThree() {
  int whichScreen = 3;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatFour() {
  int whichScreen = 4;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatFive() {
  int whichScreen = 5;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatSix() {
  int whichScreen = 6;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatSeven() {
  int whichScreen = 7;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatEight() {
  int whichScreen = 8;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatNine() {
  int whichScreen = 9;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatTen() {
  int whichScreen = 10;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatZero() {
  int whichScreen = 0;
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
    }
  }
}












void floatDown() {
  for (int i = 0; i< screenCount; i++) {
    if (lines[i]!=null) {
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

void floatMedium() {
  lines[m].index=indie;
  lines[m].tpos.y = height/2;
  fadeTime = millis() + duration;
  lines[m].opacity=map(fadeTime - millis(), 0, duration, 0, 100);
}
void findWhichScreen() {
  m = parseInt(random (0, 12));
  indie = parseInt(random(1,4));
}
void keyPressed() {
  if (key=='o') one = !one; 
  if (key=='t') two = !two;
  if (key=='r') three = !three;
  if (key=='f') four = !four;
  if (key=='i') five = !five;
  if (key=='x') six = !six;
  if (key=='s') seven = !seven;
  if (key=='e') eight = !eight;
  if (key=='n') nine = !nine;
  if (key=='t') ten = !ten;
  if (key=='z') zero = !zero;
  if (m>=12) {
    m = 0;
  }
  if (indie>=4) {
    indie = 1;
  }
  if (key=='u') {
    m = m+1;
    indie = indie+1;
    floatMedium = !floatMedium;
  }
  if (key=='p') prep = !prep;

}

