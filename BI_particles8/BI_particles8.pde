//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}

//pass a ball from one to another


ParticleSystem ps;
int passYPos;
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
PImage pointImg;
int smallPoint, largePoint;
boolean extrude, point, normal = false;
boolean onetime = true;
int[][] imgPixels;
int[][] values;
float angle;

Line [] lines;

int cx, cy;
//int index = 1;
boolean one, two, three, four, five, six, seven, eight, nine, ten, zero = false;
boolean smallText, prep, floatMedium, flow, erase, wipe, particles, makeImages, rise, doText = false;

int thiswidth;
int thisheight;

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 65;
int screenHeight = 113;  //140//MAKE THIS PORPORTIONAL TO TOTAL WALL HEIGHT
int whichScreen;
int topMargin = 5;
int screenCount = 9;
int lmargin = 10;

int m = 0;
int indie = 1;
int imageCount = screenCount-1;
//  background = loadImage( "background.jpg" );
float whatsY;

float lerpVal = 0.08;
int x = 100;


int wheresY;
int wheresOtherY;
int wheresX;
int wheresOtherX;


String text;
String[] pieces = {
  "", "Your brain can predict the future", "In fact, it's making lots of little predictions right now", "By making guesses about what comes next, the brain knows", "where to look", "when to walk", "and how to talk."
};
int textIndex = 0;
int sceneIndex = 0;
PFont font;
int fontSize = 12;
int big = 42;
int medium = 24;

void setup() {
  size(1200, 1000);

  //  size(thiswidth, thisheight+screenHeight);
  ps = new ParticleSystem(new PVector(width/2, height/2), x);


  colorMode(HSB, 360, 100, 100, 100);
  //  fill (300);

  smooth();
  font = loadFont("NimbusSanNov-Med-42.vlw");
  textFont(font);
  lines = new Line[screenCount]; 
  parse();

  images = new PImage[imageCount];
  newImages = new PImage[imageCount];
  flowImages = new PImage[imageCount];
  //   background = loadImage( "background.png" );
  pointImg = loadImage( "bb3-01.png" );

  backgroundTwo = loadImage( "backgroundTwo.png" );
  img = loadImage( "bborig-01.png" );
  imgMask = loadImage("mask2.jpg");
  thiswidth = img.width;
  thisheight = img.height;
  //  whatsY = img.height-screenHeight/2;

  backImgPos.y = 0;
  tbackImgPos.y =backgroundTwo.height/2;
  backImgPos.x = 0; //THEORETICALLY
  tbackImgPos.x =backgroundTwo.height/4;
  image(backgroundTwo, leftSide, backImgPos.x, screenWidth*screenCount, backImgPos.y);

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
  pointImg.loadPixels();
  for (int i = 0; i < pointImg.height; i++) {
    for (int j = 0; j < pointImg.width; j++) {
      imgPixels[j][i] = pointImg.pixels[i*pointImg.width + j];
      values[j][i] = int(blue(imgPixels[j][i]));
    }
  }
}

void parse() {
  for (int i = 0; i< screenCount; i++) {
    Line line = new Line();
    line.text = pieces[2];

    lines[i]=line;
  }
}

void draw() {

  if (point) {
    pointillize();
  }
  if (makeImages) {
    makeImageScreens();
  }

  if (normal) {
    background(360);
    fill(360);
    rect(width/2-(screenWidth*screenCount)/2, 0, img.width+screenWidth/2+22, img.height);

    backImgPos.y = lerp(backImgPos.y, tbackImgPos.y, lerpVal);
    backImgPos.x = lerp(backImgPos.x, tbackImgPos.x, lerpVal);

    newBackImgPos.y = lerp(newBackImgPos.y, tNewBackImgPos.y, .03);
    newBackImgPos.x = lerp(newBackImgPos.x, tNewBackImgPos.x, .03);

    leftSide = width/2;
    rightSide =  width/2+(screenWidth*screenCount)/2;
    image(backgroundTwo, width/2, height/2-140);

    for (int i = 0; i< screenCount; i++) {
      lines[i].update();
      lines[i].render();
      lines[i].text = pieces[textIndex];
    }
    if (wipe) {
      wipe();
    }
    if (prep) {
      floatPrep();
    }
    if (rise) {
      riseUp();
    }
    if (floatMedium) {
      floatMedium();
    }
    if (flow) {
      //      imageFlow();
    }



    if (particles) {
      background(360);
      image(backgroundTwo, width/2, height/2-140);
      fill(360);
      rect(width/2-(screenWidth*screenCount)/2, 0, img.width+screenWidth/2+22, img.height);
      for (int i = 0; i< screenCount; i++) {
        lines[i].update();
        lines[i].render();
      }   
      makeParticles();
    }

    if (doText) {
      fill(0);
      if (sceneIndex<3) {
        textSize(big);
        text(pieces[sceneIndex], width/2-screenWidth*screenCount/2, lines[0].pos.y, screenWidth*screenCount, screenHeight);
      }
      if (sceneIndex>=3 && sceneIndex<=12) {
        textSize(medium);
        //where to walk
        text(pieces[3], width/2-screenWidth*screenCount/2, lines[0].pos.y, screenWidth*3, screenHeight);
      }
    }

    if (smallText) {
      smallText();
    }
  }
  println (sceneIndex+"sceneIndex");
}
void mouseClicked() {
  sceneIndex += 1; 
  newScene();
}

void newScene() {
  for (int i = 0; i<lines.length; i++) {
    if (sceneIndex == 1) {
      lines[i].tpos.y = height/3;
    }
    if (sceneIndex == 3) {
      //where to walk, where to walk, where to walk
      lines[i].tpos.y = 0;
      lines[3].tpos.y = height/5;
    }
    if (sceneIndex==4) {
      lines[4].tpos.y = height/5;
    }
  }
}
void smallText() {
  textSize(18);
  if (sceneIndex==3) {
    lines[3].text = pieces[4];
    lines[3].textWidth = screenWidth;
  }
  if (sceneIndex==4) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    //    lines[3].textWidth = screenWidth;
    lines[4].textWidth = screenWidth;
  }
  if (sceneIndex==5) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    lines[5].text = pieces[5];
    lines[5].textWidth = screenWidth;
  }
  //OPTION 1: WHERE TO WALK: WHERE TO LOOK SCREENS BECOME WHERE TO WALK 
  //  if (sceneIndex==6) {
  //    lines[5].text = pieces[5]; //where to walk, waiting at top
  //    lines[4].text = pieces[5]; //first turns to where to walk, then walks
  //  }
  //  if (sceneIndex==7) {
  //    lines[3].lerpVal = .005;
  //    lines[4].lerpVal = .009;
  //    lines[3].tpos.y = 0; 
  //    lines[4].tpos.y = 0;
  //
  //    lines[5].text = pieces[5];
  //    lines[4].text = pieces[5];
  //    lines[3].text = pieces[5];
  //  }

  //OPTION 2: WHERE TO WALK: WHERE TO LOOK SCREENS PERSIST AND NEW ONES BECOME WHERE TO WALK 
  if (sceneIndex==6) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    lines[5].text = pieces[5];

    lines[3].lerpVal = .005;
    lines[4].lerpVal = .009;

    lines[3].tpos.y = height/6; 
    lines[4].tpos.y = height/6;
    //    lines[5].text = pieces[5]; //where to walk, waiting at top
  }
  //  if (sceneIndex==7) {
  //    lines[3].text = pieces[4];
  //    lines[4].text = pieces[4];
  //    
  //    lines[5].text = pieces[5]; //where to walk, waiting at top
  //
  //  }
  if (sceneIndex==7) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    lines[5].text = pieces[5];
    lines[6].lerpVal = .01;
    lines[6].tpos.y = height/3;
  }
  if (sceneIndex==8) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    lines[5].text = pieces[5];
    lines[5].tpos.y = height/3;
    lines[6].textWidth = screenWidth;
    lines[6].text = pieces[5];
  }
  if (sceneIndex==9) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    lines[5].text = pieces[5];
    lines[6].text = pieces[5];
    lines[6].text = pieces[5];
    
        lines[7].textWidth = screenWidth*2;
//        lines[8].textWidth = screenWidth;
    lines[7].text = pieces[6];
//    lines[8].text = pieces[6];
  }
  if (sceneIndex==10) {
    lines[3].text = pieces[4];
    lines[4].text = pieces[4];
    lines[5].text = pieces[5];
    lines[6].text = pieces[5];
    lines[6].text = pieces[5];
    
        lines[7].textWidth = screenWidth;
        lines[8].textWidth = screenWidth;
    lines[7].text = pieces[6];
    lines[8].text = pieces[6];
  }
}

void pointillize() {
  noStroke();
  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int whichX = wheresX;
  int whichY = int(random(wheresY+screenHeight/2+10, wheresY+screenHeight+50));
  println (wheresY+screenHeight/2);
  println (wheresY + screenHeight);

  color whichPix = pointImg.get(whichX, whichY);
  fill(whichPix, 128);
  ellipse(whichX, whichY, pointillize, pointillize);

  int anotherX = wheresOtherX;
  int anotherY = int(random(wheresOtherY+screenHeight/2+10, wheresOtherY+screenHeight+50));

  color anotherPix = pointImg.get(anotherX, anotherY);
  fill(anotherPix, 128);
  ellipse(anotherX, anotherY, pointillize, pointillize);
}

void makeParticles() {
  x = passYPos;
  ps.addParticle();
  ps.run();
}
void floatPrep() {

  for (int i = 0; i< screenCount; i++) {
    if (lines[i] != null) {
      int leftScreen = width/2-(screenWidth*screenCount)/2;
      int rightScreen = width/2+(screenWidth*screenCount)/2;

      float screenX = map(i, 0, screenCount, leftScreen, rightScreen); 

      lines[i].opacity.x = 255;  // Apply transparency without changing color
      lines[i].topacity.x=255;

      lines[i].cx = screenX;
      lines[i].cy = 0; 
      lines[i].tpos.y = 0; //do you get to control this in prep??????

      lines[i].tpos.x = 0;

      //    image(newImages[index], pos.x, pos.y, imgPos.x, imgPos.y);
      //      lines[i].timgPos.x = 0;
      //      lines[i].timgPos.y = 0;
    }
  }
}

void makeImageScreens() {
  for (int i = 0; i< screenCount; i++) {
    lines[i].imgPos.x = 0;
    lines[i].timgPos.x = screenWidth;
    lines[i].timgPos.y = screenHeight;
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
    leftie = width/2-img.width/2;
    rightie = width/2+img.width/2;
    tNewBackImgPos.x = height/2-140;
    tNewBackImgPos.y = img.height;

    floatAny(i);

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
  //  x = parseInt(lines[3].tpos.y);

  passYPos =parseInt(lines[makeItInt].tpos.y); 
  lines[makeItInt].tpos.y = img.height+topMargin;
}

void riseUp() {
  //  x = parseInt(lines[3].tpos.y);
  for (int i = 0; i<screenCount; i++) {
    passYPos =parseInt(lines[i].tpos.y); 
    lines[i].tpos.y = 0;
  }
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
  m = parseInt(random (0, screenCount-1));
  indie = parseInt(random(1, images.length));
}






void floatRandom() { 
  for (int i = 1; i<lines.length; i++) {
    lines[i].lerpVal = .01;
  }
  lines[3].pos.y = 0;

  lines[3].tpos.y = img.height+topMargin;
  lines[5].tpos.y = 0;
  lines[6].tpos.y = img.height+topMargin;
  lines[8].tpos.y = 0;

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
  lines[8].tpos.y =  img.height+topMargin;

  lines[3].pos.y = 0;
  lines[6].pos.y = 0;

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
  makeItInt = parseInt(map(whichScreen, 48, 58, 0, screenCount));

  if (makeItInt<screenCount && makeItInt>=0) {
    floatAny(makeItInt);
  }

  if (key=='l') flow = !flow;

  if (key=='w') wipe = !wipe;
  if (m>=screenCount-1) {
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
  if (key=='i') makeImages = !makeImages;

  if (key=='p') prep = !prep;
  if (key=='a') particles = !particles;
  if (key=='z') point = !point;
  if (key=='e') extrude = !extrude;
  if (key=='n') normal = !normal;
  //  if (key=='m') medium = !medium;
  if (key=='s') rise = !rise;
  if (key=='x') smallText=!smallText;
  if (key=='t') doText = !doText;
}

