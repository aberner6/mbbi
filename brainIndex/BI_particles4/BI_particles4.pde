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
float rightie;
float leftie;
int fadeFrom = 0;
int fadeTo = 255;
int backgroundTrans = 255;
PVector backImgPos = new PVector();
PVector tbackImgPos = new PVector();
PVector newBackImgPos = new PVector();
PVector tNewBackImgPos = new PVector(); 

float widthIs = 598.5;
float heightIs = 443;
PImage img;
int smallPoint, largePoint;
boolean extrude, point, normal = false;
boolean onetime = true;
int[][] imgPixels;
int[][] values;
float angle;


PFont font;
int fontSize = 12;

Line [] lines;

int cx, cy;
//int index = 1;
boolean one, two, three, four, five, six, seven, eight, nine, ten, zero = false;
boolean prep, floatMedium, flow, erase, wipe, particles = false;

int thiswidth;
int thisheight;

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 65;
int screenHeight = 113;  //140//MAKE THIS PORPORTIONAL TO TOTAL WALL HEIGHT
int whichScreen;
int topMargin = 5;
int screenCount = 11;
int lmargin = 10;

int m = 0;
int indie = 1;
int imageCount = 5+screenCount;
//  background = loadImage( "background.jpg" );
float whatsY;

float lerpVal = 0.08;
int x = 100;


int wheresY;
int wheresOtherY;
int wheresX;
int wheresOtherX;

void setup() {
  size(1200, 1000);

  //  size(thiswidth, thisheight+screenHeight);
  ps = new ParticleSystem(new PVector(width/2, height/2), x);


  colorMode(HSB, 360, 100, 100, 100);
  //  fill (300);

  smooth();

  lines = new Line[screenCount]; 
  parse();

  images = new PImage[imageCount];
  newImages = new PImage[imageCount];
  flowImages = new PImage[imageCount];
  //   background = loadImage( "background.png" );

  img = loadImage( "bb3.png" );
  backgroundTwo = loadImage( "brainImg.png" );
  imgMask = loadImage("mask2.jpg");
  thiswidth = img.width;
  thisheight = img.height;
  //  whatsY = img.height-screenHeight/2;

  backImgPos.y = 0;
  tbackImgPos.y =height/2-140;
  backImgPos.x = width; //THEORETICALLY
  tbackImgPos.x = 0;

  for (int t=1;t<5;t++) {
    images[t] = loadImage( "" + t + ".jpg" );
    newImages[t] = images[t];
  };


  smallPoint = 1;
  largePoint = 60;
  imageMode(CENTER);
  noStroke();
  smooth(8);
  imgPixels = new int[width][height];
  values = new int[width][height];
  noFill();
  // Load the image into a new array
  // Extract the values and store in an array
  //  a = loadImage("bb3.png");
  img.loadPixels();
  for (int i = 0; i < img.height; i++) {
    for (int j = 0; j < img.width; j++) {
      imgPixels[j][i] = img.pixels[i*img.width + j];
      values[j][i] = int(blue(imgPixels[j][i]));
    }
  }
}

void parse() {
  for (int i = 0; i< screenCount; i++) {
    Line line = new Line();
    lines[i]=line;
  }
}

void draw() {
  if (mousePressed) {
    //    background(360);
    strokeWeight(1);
    stroke(100);
    //    noFill();
    //    fill(360);
    //    image(img, width/2, height/2-140);
    //    rect(width/2-img.width/2, 0, img.width, img.height);
  } 
  if (point) {
    pointillize();
  }

  if (normal) {
    background(360);
    rect(width/2-img.width/2, 0, img.width, img.height);

    backImgPos.y = lerp(backImgPos.y, tbackImgPos.y, lerpVal);
    backImgPos.x = lerp(backImgPos.x, tbackImgPos.x, lerpVal);

    newBackImgPos.y = lerp(newBackImgPos.y, tNewBackImgPos.y, .03);
    newBackImgPos.x = lerp(newBackImgPos.x, tNewBackImgPos.x, .03);

    leftSide = width/2;

    //    leftSide = width/2-(screenWidth*screenCount)/2;
    rightSide =  width/2+(screenWidth*screenCount)/2;
    //    tint(255, backgroundTrans);  // Apply transparency without changing color


    //set values in setup
    //then change them in the first function if i want them to change

    image(backgroundTwo, leftSide, backImgPos.x, screenWidth*screenCount, backImgPos.y);
    image(img, leftSide, newBackImgPos.x, rightie, newBackImgPos.y);

    //    image(img, leftSide, newBackImgPos.x, screenWidth*screenCount, newBackImgPos.y-screenHeight*2/3);

    ////FIGURE OUT TRANSITION FOR BACKGROUND IMAGE AGAIN
    //    image(img, width/2, height/2-140);

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
      //      imageFlow();
    }



    if (particles) {
      background(360);
      image(img, width/2, height/2-140);
      rect(width/2-img.width/2, 0, img.width, img.height);
      for (int i = 0; i< screenCount; i++) {
        lines[i].update();
        lines[i].render();
      }   
      makeParticles();
    }
  }
}


void pointillize() {
  noStroke();
  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int whichX = wheresX;
  int whichY = int(random(wheresY+screenHeight/2+10, wheresY+screenHeight+50));
  println (wheresY+screenHeight/2);
  println (wheresY + screenHeight);

  color whichPix = img.get(whichX, whichY);
  fill(whichPix, 128);
  ellipse(whichX, whichY, pointillize, pointillize);

  int anotherX = wheresOtherX;
  int anotherY = int(random(wheresOtherY+screenHeight/2+10, wheresOtherY+screenHeight+50));

  color anotherPix = img.get(anotherX, anotherY);
  fill(anotherPix, 128);
  ellipse(anotherX, anotherY, pointillize, pointillize);
}

void makeParticles() {
  x = parseInt(lines[3].tpos.y);
  ps.addParticle();
  ps.run();
}
void floatPrep() {

  for (int i = 0; i< screenCount; i++) {
    if (lines[i] != null) {
      int leftScreen = width/2-(screenWidth*screenCount)/2;
int rightScreen = width/2+(screenWidth*screenCount)/2;
//      int rightScreen = width/2+img.width/2-screenWidth/2;
// width/2-img.width/2+screenWidth/2
      float screenX = map(i, 0, screenCount,leftScreen,rightScreen); 
      lines[i].opacity.x = 255;  // Apply transparency without changing color
      lines[i].topacity.x=255;

      lines[i].imgPos.x = screenWidth*2;
      lines[i].timgPos.x = screenWidth*2;
      lines[i].timgPos.y = screenHeight*2;

      lines[i].cx = screenX;
      lines[i].cy = 0; 
      lines[i].tpos.y = 0;

      lines[i].tpos.x = 0;

//    image(newImages[index], pos.x, pos.y, imgPos.x, imgPos.y);
//      lines[i].timgPos.x = 0;
//      lines[i].timgPos.y = 0;
    }
  }
}
void wipe() {
  for (int i = 0; i< screenCount; i++) {
    //    lines[i].tpos.y = img.height-140;
    backImgPos.y = 0; 
    tbackImgPos.y = 0; 

    //    newBackImgPos.x = width/2-img.height/2;
    //    tNewBackImgPos.y = img.height-140;
    //    image(img, leftSide, newBackImgPos.x, screenWidth*screenCount, newBackImgPos.y-screenHeight*2/3);
    leftie = width/2-img.width/2+200;
    rightie = width/2+img.width/2-200;
    tNewBackImgPos.x = height/2-140;
    tNewBackImgPos.y = img.height;


    //    image(backgroundTwo, leftSide, backImgPos.x, screenWidth*screenCount, backImgPos.y-screenHeight*2/3);
    //
    //    image(img, leftSide, newBackImgPos.x, screenWidth*screenCount, newBackImgPos.y-screenHeight*2/3);
    //    
    ////FIGURE OUT TRANSITION FOR BACKGROUND IMAGE AGAIN
    //    image(img, width/2, height/2-140);



//    image(backgroundTwo, leftSide, backImgPos.x, screenWidth*screenCount, backImgPos.y);
//    image(img, leftSide, newBackImgPos.x, rightie, newBackImgPos.y);
  }
}

void floatAny(int makeItInt) {
  lines[makeItInt].tpos.y = img.height+topMargin;
}



void floatMedium() {   
  lines[m].tpos.y = height/2;
  float whereIsIt = lines[m].tpos.y;
  float whereIsItGoing = map(whereIsIt, 0, height/2, 0, height);
  if (lines[m].pos.y<height/2+10 && lines[m].pos.y>height/2-10) {
    lines[m].index=indie;
  }
}

void findWhichScreen() {
  m = parseInt(random (0, screenCount));
  indie = parseInt(random(1, images.length));
}






void floatRandom() { 
  for (int i = 1; i<lines.length; i++) {
    lines[i].lerpVal = .01;
  }
  lines[3].tpos.y = img.height+topMargin;
  lines[5].tpos.y = 0;
  lines[6].tpos.y = img.height+topMargin;
  lines[9].tpos.y = 0;

  if (lines[3].pos.y<img.height/2+10 && lines[3].pos.y>img.height/2-10) {
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
  lines[5].tpos.y =  img.height+topMargin;
  lines[9].tpos.y =  img.height+topMargin;


  wheresY = img.height/4;
  wheresOtherY = img.height/3;
  wheresX = round(lines[3].cx)+screenWidth/2;
  wheresOtherX = round(lines[6].cx)+screenWidth/2;

  lines[3].tpos.y = wheresY+screenHeight/2;
  lines[6].tpos.y = wheresOtherY+screenHeight/2;

  if (lines[3].pos.y<img.height/2+10 && lines[3].pos.y>img.height/2-10) {
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
  if (key=='z') point = !point;
  if (key=='e') extrude = !extrude;
  if (key=='n') normal = !normal;
  //  if (key=='m') medium = !medium;
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




//void imageFlow() {
////    imgPos.x = lerp(imgPos.x, timgPos.x, lerpVal);
////    imgPos.y = lerp(imgPos.y, timgPos.y, lerpVal);
////
////    image(newImages[index], pos.x, pos.y, imgPos.x, imgPos.y);
//  lines[0].pos.x = 0;
//  lines[0].timgPos.y = screenHeight;      
//  lines[0].timgPos.x = width; // (screenWidth*(screenCount))*2+screenWidth
////  for (int i = 1; i<lines.length; i++) {
////    lines[i].topacity.x=fadeFrom;
////  }
////  newImages[3] = images[3].get(0, 0, screenWidth*screenCount+1, screenHeight);    
//  newImages[3] = images[3].get(0, 0, 500, screenHeight);    
//
//  lines[0].index=3;
//}



////DOESN'T WORK VERY WELL
//void pointillize(){
//  //  int x = int(random(img.width));
//  //  int y = int(random(img.height));
//  noStroke();
//  float pointillize = map(mouseX, 0, width, smallPoint, 10);
//
//    int x = int(random(50+width/2-img.width/2, width/2-screenWidth/2));
//    int y = int(random(img.height/2, img.height/2+screenHeight));
//    
//    int otherx = int(random(width/2+screenWidth/2, width/2+img.width/2-50));
//    int othery = int(random(img.height/2, img.height/2+screenHeight));
//    
//    color pix = img.get(x, y);
//    fill(pix, 128);
//    ellipse(x, y, pointillize, pointillize);
//
//    color otherpix = img.get(otherx, othery);
//    fill(otherpix, 128);
//    ellipse(otherx, othery, pointillize, pointillize);
//  
//}


