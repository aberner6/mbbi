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
PImage flowImages[];
int index;
PImage background;
PImage firstBackground;
float leftSide;
float rightSide;
int fadeFrom = 0;
int fadeTo = 255;

PFont font;
int fontSize = 12;

Line [] lines;

int cx, cy;
//int index = 1;
boolean one, two, three, four, five, six, seven, eight, nine, ten, zero = false;
boolean prep, floatMedium, flow = false;

int thiswidth= 1200; //(1440 x 900)
int thisheight = 515; //1920 x 1080

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 60;
int screenHeight = 140;
int whichScreen;
int topMargin = -10;
int screenCount = 10;
int lmargin = 10;

int m = 0;
int indie = 1;
int imageCount = 5+screenCount;
void setup() {
  //  size(thiswidth-115, thisheight+screenHeight); //size(1500, 750); //100
  //  size(screenWidth*screenCount, thisheight+screenHeight); //size(1500, 750); //100
  size(thiswidth, thisheight+screenHeight);
  colorMode(HSB, 360, 100, 100);
  fill (300);

  smooth();

  lines = new Line[screenCount]; 
  parse();

//  imageCount = 5;
  images = new PImage[imageCount];
  newImages = new PImage[imageCount];
  flowImages = new PImage[imageCount];
  background = loadImage( "background.jpg" );

  //  firstBackground = loadImage( "background.jpg" );
  //  background = firstBackground.get(0,0,screenWidth*screenCount,thisheight);    

  //  images[0] = loadImage( "background.jpg" );
  for (int t=1;t<5;t++) {
    images[t] = loadImage( "" + t + ".jpg" );
    newImages[t] = images[t];
    //newImages[t] = images[t].get(0,0,screenWidth,screenHeight);
  };
}

void parse() {
  for (int i = 0; i< screenCount; i++) {
    Line line = new Line();
    lines[i]=line;
  }
}

void draw() {
  background(360);

  //    size(screenWidth*screenCount, thisheight+screenHeight); //size(1500, 750); //100
  leftSide = width/2-(screenWidth*screenCount)/2;
  rightSide =  width/2+(screenWidth*screenCount)/2;
  tint(255, 255);  // Apply transparency without changing color
  image(background, leftSide, 0, screenWidth*screenCount, background.height*2/3);

  //  image(background, 0, 0, background.width*2/3, background.height*2/3);
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
    //    floatTen();
  }
  if (prep) {
    floatPrep();
  }
  if (floatMedium) {
    floatMedium();
  }
  if (flow) {
    imageFlow();
  }
}
void floatPrep() {
  for (int i = 0; i< screenCount; i++) {
    if (lines[i] != null) {
      //        size(screenWidth*screenCount, thisheight+screenHeight); //size(1500, 750); //100

      float screenX = map(i, 0, screenCount, leftSide, rightSide); 
      lines[i].opacity.x = 255;  // Apply transparency without changing color
      lines[i].topacity.x=255;

      lines[i].imgPos.x = screenWidth;
      lines[i].timgPos.x = screenWidth;
      lines[i].timgPos.y = screenHeight;
      //    PVector imgPos = new PVector();
      //  PVector timgPos = new PVector();

      lines[i].cx = screenX;
      lines[i].cy = 0; 
      lines[i].tpos.x = 0;
      lines[i].tpos.y = 0;
      //      lines[i].opacity = 255;
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
//void floatTen() {
//  int whichScreen = 10;
//  for (int i = 0; i< screenCount; i++) {
//    if (lines[i]!=null) {
//      lines[whichScreen].tpos.y = height-screenHeight+topMargin;
//    }
//  }
//}
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
      float screenX = map(i, 0, screenCount-1, lmargin, screenWidth*screenCount); 
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

  lines[m].tpos.y = height/2;
  float whereIsIt = lines[m].tpos.y;
  float whereIsItGoing = map(whereIsIt, 0, height/2, 0, height);
  println(whereIsIt);
  //  lines[m].topacity.x=fadeTo;
  //  lines[m].opacity.x = fadeTo;  // Apply transparency without changing color

  if (lines[m].pos.y>height/2-10) {
    lines[m].index=indie;
    //  lines[m].topacity.x=fadeTo;
    //  lines[m].opacity.x = fadeFrom;  // Apply transparency without changing color
  };
}
void imageFlow(){
  lines[0].imgPos.x = 0;
  lines[0].timgPos.x = (screenWidth*(screenCount))*2+screenWidth;
for (int i = 1; i<lines.length; i++){
   lines[i].topacity.x=fadeFrom;
}
newImages[3] = images[3].get(0,0,screenWidth*screenCount+1,screenHeight);    

   lines[0].index=3;    
}


//void imageFlow() {
////  lines[0].imgPos.x = 0;
////  lines[0].timgPos.x = (screenWidth*(screenCount))*2+screenWidth;
////  for (int i = 1; i<lines.length; i++) {
////    lines[i].topacity.x=fadeFrom;
////  }

//  for (int i = imageCount; i<screenCount; i++) {
//    for (int j = 0; j<screenCount; j++){
//    newImages[i] = images[1].get(0, 0, screenWidth*j, screenHeight);  
//
//    }
//  }
//  lines[0].index = 7;

////  lines[0].index=3;
//}


void findWhichScreen() {
  m = parseInt(random (0, screenCount));
  indie = parseInt(random(1, images.length));
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
  if (key=='l') flow = !flow;

  if (m>=screenCount) {
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

