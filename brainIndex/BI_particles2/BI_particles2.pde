//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}
ParticleSystem ps;

int fadeTime = 0;
int duration = 4000; // Dauer des Fades in Millisekunden
PImage images[];
PImage newImages[];
PImage flowImages[];
int index;
PImage background;
PImage backgroundTwo;
PImage imgMask;
float leftSide;
float rightSide;
int fadeFrom = 0;
int fadeTo = 255;
int backgroundTrans = 255;
PVector backImgPos = new PVector();
PVector tbackImgPos = new PVector();
PVector newBackImgPos = new PVector();
PVector tNewBackImgPos = new PVector(); 



PFont font;
int fontSize = 12;

Line [] lines;

int cx, cy;
//int index = 1;
boolean one, two, three, four, five, six, seven, eight, nine, ten, zero = false;
boolean prep, floatMedium, flow, erase, wipe, particles = false;

int thiswidth= 900; //(1440 x 900)
int thisheight = 600; //1920 x 1080

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 60;
int screenHeight = 140;  //140//MAKE THIS PORPORTIONAL TO TOTAL WALL HEIGHT
int whichScreen;
int topMargin = -10;
int screenCount = 11;
int lmargin = 10;

int m = 0;
int indie = 1;
int imageCount = 5+screenCount;
//  background = loadImage( "background.jpg" );
float whatsY;

float lerpVal = 0.08;
int x = 100;

void setup() {
  size(thiswidth, thisheight+screenHeight);
  ps = new ParticleSystem(new PVector(width/2, height/2), x);


  colorMode(HSB, 360, 100, 100, 100);
  fill (300);

  smooth();

  lines = new Line[screenCount]; 
  parse();

  images = new PImage[imageCount];
  newImages = new PImage[imageCount];
  flowImages = new PImage[imageCount];
  //   background = loadImage( "background.png" );

  background = loadImage( "background.jpg" );
  backgroundTwo = loadImage( "brainImg.png" );
  imgMask = loadImage("mask2.jpg");

  whatsY = background.height-screenHeight/2;

  backImgPos.y = whatsY;
  tbackImgPos.y = whatsY;
  backImgPos.x = 200; //THEORETICALLY
  tbackImgPos.x = 0;

  for (int t=1;t<5;t++) {
    images[t] = loadImage( "" + t + ".jpg" );
    newImages[t] = images[t];
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

  backImgPos.y = lerp(backImgPos.y, tbackImgPos.y, lerpVal);
  backImgPos.x = lerp(backImgPos.x, tbackImgPos.x, lerpVal);

  newBackImgPos.y = lerp(newBackImgPos.y, tNewBackImgPos.y, .03);
  newBackImgPos.x = lerp(newBackImgPos.x, tNewBackImgPos.x, .03);

  leftSide = width/2-(screenWidth*screenCount)/2;
  rightSide =  width/2+(screenWidth*screenCount)/2;
  tint(255, backgroundTrans);  // Apply transparency without changing color


  //set values in setup
  //then change them in the first function if i want them to change
  //  image(background, leftSide, 0, screenWidth*screenCount, background.height*2/3);

  image(background, leftSide, backImgPos.x, screenWidth*screenCount, backImgPos.y);

  image(backgroundTwo, leftSide, newBackImgPos.x, screenWidth*screenCount, newBackImgPos.y);

  for (int i = 0; i< screenCount; i++) {
    lines[i].update();
    lines[i].render();
  }
  if (wipe) {
    wipe();
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
  if (particles) {
    makeParticles();
  }
}
void makeParticles() {
//  for (int i = 0; i<ps.length; i++){
//  ps[i].particleX = 10;
//  ps[i].particleY = 10;
//  }
x=200;
//  ps = new ParticleSystem(new PVector(width/2, height/2), x);

  ps.addParticle();
  ps.run();
}
void floatPrep() {

  for (int i = 0; i< screenCount; i++) {
    if (lines[i] != null) {

      float screenX = map(i, 0, screenCount, leftSide, rightSide); 
      lines[i].opacity.x = 255;  // Apply transparency without changing color
      lines[i].topacity.x=255;

      lines[i].imgPos.x = screenWidth;
      lines[i].timgPos.x = screenWidth;
      lines[i].timgPos.y = screenHeight;

      lines[i].cx = screenX;
      lines[i].cy = 0; 
      lines[i].tpos.y = 0;

      lines[i].tpos.x = 0;
    }
  }
}
void wipe() {
  for (int i = 0; i< screenCount; i++) {
    lines[i].tpos.y = height-screenHeight+topMargin;
    tbackImgPos.y = 0; 
    tNewBackImgPos.y = lines[i].tpos.y;
  }
}

void floatAny(int makeItInt) {
  lines[makeItInt].tpos.y = height-screenHeight+topMargin;
}



void floatMedium() {   

  lines[m].tpos.y = height/2;
  float whereIsIt = lines[m].tpos.y;
  float whereIsItGoing = map(whereIsIt, 0, height/2, 0, height);
  if (lines[m].pos.y<height/2+10 && lines[m].pos.y>height/2-10) {
    lines[m].index=indie;
  }
}
void imageFlow() {
  lines[0].imgPos.x = 0;
  lines[0].timgPos.x = (screenWidth*(screenCount))*2+screenWidth;
  for (int i = 1; i<lines.length; i++) {
    lines[i].topacity.x=fadeFrom;
  }
  newImages[3] = images[3].get(0, 0, screenWidth*screenCount+1, screenHeight);    

  lines[0].index=3;
}
//void eraseBackground() {
//  //whatsY = lerp(background.height*2/3,-background.height*6, .09);
//int millis = frameCount%10;
//for (int i = 0; i<255; i++){
//  //SLOW THIS DOWN HOW?
//  backgroundTrans = 255-i;
//}
////backgroundTrans = 0; 
//}


void findWhichScreen() {
  m = parseInt(random (0, screenCount));
  indie = parseInt(random(1, images.length));
}





//FLOAT RANDOM AND FLOAT ON NEED TO STOP BEFORE THEY GET TO THE GROUND

void floatRandom() { 
  for (int i = 1; i<lines.length; i++) {
    lines[i].lerpVal = .01;
  }
  lines[3].tpos.y = height;
  lines[5].tpos.y = 0;
  lines[6].tpos.y = height;
  lines[9].tpos.y = 0;

  if (lines[3].pos.y<height/2+10 && lines[3].pos.y>height/2-10) {
    lines[3].index=indie;
  }
  else { 
    lines[3].index=1;
  }
}
void floatOn() {
    for (int i = 1; i<lines.length; i++) {
  lines[i].lerpVal = .01;  
    }
  lines[5].tpos.y = height;
  lines[3].tpos.y = 0;
  lines[9].tpos.y = height;
  lines[6].tpos.y = 0;

  if (lines[3].pos.y<height/2+10 && lines[3].pos.y>height/2-10) {
    lines[3].index=indie;
  }
  else { 
    lines[3].index=1;
  }
}




void keyPressed() {
  println(key+"this key");
  if (key=='r') floatRandom();
  if (key=='o') floatOn();
  whichScreen = parseInt(key);
  int makeItInt;
  makeItInt = parseInt(map(whichScreen, 48, 58, 0, 10));

  if (makeItInt<11 && makeItInt>=0) {
    floatAny(makeItInt);
  }
  if (key=='t') {
    floatAny(10);
  }
  if (key=='l') flow = !flow;
  if (key == 'e') erase = !erase;
  if (key=='w') wipe = !wipe;
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
  if (key=='a') particles = !particles;
}



















//  if (key<57 && key>=48){
//    
//  whichScreen = parseInt(key);
//  println (key);
//    floatAny(whichScreen);
//  }
//  if (key=='o') one = !one; 
//  if (key=='t') two = !two;
//  if (key=='r') three = !three;
//  if (key=='f') four = !four;
//  if (key=='i') five = !five;
//  if (key=='x') six = !six;
//  if (key=='s') seven = !seven;
//  if (key=='e') eight = !eight;
//  if (key=='n') nine = !nine;
//  if (key=='t') ten = !ten;
//  if (key=='z') zero = !zero;

//
//void floatOne() {
//  int whichScreen = 1;
//  floatAny(whichScreen);
//}
//void floatTwo() {
//  int whichScreen = 2;
//  floatAny(whichScreen);
//}
//void floatThree() {
//  int whichScreen = 3;
//  floatAny(whichScreen);
//}
//void floatFour() {
//  int whichScreen = 4;
//  floatAny(whichScreen);
//}
//void floatFive() {
//  int whichScreen = 5;
//  floatAny(whichScreen);
//}
//void floatSix() {
//  int whichScreen = 6;
//  floatAny(whichScreen);
//}
//void floatSeven() {
//  int whichScreen = 7;
//  floatAny(whichScreen);
//}
//void floatEight() {
//  int whichScreen = 8;
//  floatAny(whichScreen);
//}
//void floatNine() {
//  int whichScreen = 9;
//  floatAny(whichScreen);
//}
//void floatZero() {
//  int whichScreen = 0;
//  floatAny(whichScreen);
//}


//
//  if (zero) {
//    floatZero();
//  }
//  if (one) {
//    floatOne();
//  }
//  if (two) {
//    floatTwo();
//  }
//  if (three) {
//    floatThree();
//  }
//  if (four) {
//    floatFour();
//  }
//  if (five) {
//    floatFive();
//  }
//  if (six) {
//    floatSix();
//  }
//  if (seven) {
//    floatSeven();
//  }
//  if (eight) {
//    floatEight();
//  }
//  if (nine) {
//    floatNine();
//  }
//  if (eight) {
//    //    floatTen();
//  }

