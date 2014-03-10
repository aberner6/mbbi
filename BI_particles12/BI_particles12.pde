//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}

//pass a ball from one to another

import processing.video.*;
Movie myMovie;

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
boolean smallText, vid, prep, floatMedium, flow, erase, wipe, particles, makeImages, rise, doText = false;

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
  "", "Your brain can predict the future", "In fact, it's making lots of little predictions right now", "By making guesses about what comes next, the brain knows", "where to look", "when to walk", "and how to talk.", "mumble", 
  "When your brain guesses right,", "you feel like things are running smoothly.", "But sometimes the brain guesses wrong", "(nobody is perfect)", 
  "Scientists call these mistakes 'prediction errors.'", 
  "When the brain registers an error, it adapts to become a better predictor.", "It learns", "Learning involves brain areas responsible for memory", "the hippocampus", "and brain areas responsible for motivation and reward", "the striatum", 
  "These areas are active both when we're forming memories", "and when we're making decisions based on those memories.", "but...", "How do we know they're active?", "Some researchers measure brain activity through functional magnetic resonance imaging, or fMRI", 
  "fMRI uses a giant magnet to track blood flow in the brain", 
  "Blood flows to areas of expected brain activity to provide busy neurons with fuel.", 
  "For example, when the brain expects you to see something, blood flows to the visual cortex.", 
  "So by watching blood flow, scientists can tell which brain areas are hard at work."
};
int textIndex = 0;
int sceneIndex = 0;
PFont fontBig;
PFont fontMedium;
PFont fontSmall;
int fontSize = 12;
int big = 42;
int medium = 24;

void setup() {
  size(1200, 800);

  //  size(thiswidth, thisheight+screenHeight);
  ps = new ParticleSystem(new PVector(width/2+300, height/2), x);

  myMovie = new Movie(this, "vid.mov");
  myMovie.loop();

  colorMode(HSB, 360, 100, 100, 100);
  //  fill (300);

  smooth();
  fontBig = loadFont("NimbusSanNov-Med-36.vlw");
  fontMedium = loadFont("NimbusSanNov-Med-18.vlw");
  fontSmall = loadFont("NimbusSanNov-Med-14.vlw");
  textAlign(CENTER);
  //  textFont(font);
  lines = new Line[screenCount]; 
  parse();

  images = new PImage[imageCount];
  newImages = new PImage[imageCount];
  flowImages = new PImage[imageCount];
  //   background = loadImage( "background.png" );
  pointImg = loadImage( "bb3-01.png" );

  backgroundTwo = loadImage( "bb1.png" );
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
//  vid=true;
  if (vid) {
    background(360);
    //    fill(360);
    //    rect(width/2-(screenWidth*screenCount)/2, 0, img.width+screenWidth/2+22, img.height);
    for (int i = 0; i< screenCount; i++) {
      lines[i].update();
      lines[i].render();
      lines[i].text = pieces[textIndex];
      //      stroke(100,40);
      strokeWeight(.2);
      line(lines[i].cx, 0, lines[i].cx, height);
      image(myMovie, width/2, height/2);
      line(lines[i].cx, 0, lines[i].cx, height);
      line(lines[screenCount-1].cx+screenWidth, 0, lines[screenCount-1].cx+screenWidth, height);
      lines[i].update();
      lines[i].render();
      lines[i].text = pieces[textIndex];
//      noFill();
//      rect(width/2-(screenWidth*screenCount)/2, 0, img.width+screenWidth/2+22, img.height);
    }
    //    image(myMovie,width/2,height/2);
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
      //      stroke(100,40);
      strokeWeight(.2);
      line(lines[i].cx, 0, lines[i].cx, height);
      line(lines[screenCount-1].cx+screenWidth, 0, lines[screenCount-1].cx+screenWidth, height);
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



    //    if (particles) {
    //      background(360);
    //      image(backgroundTwo, width/2, height/2-140);
    //      fill(360);
    //      rect(width/2-(screenWidth*screenCount)/2, 0, img.width+screenWidth/2+22, img.height);
    //      for (int i = 0; i< screenCount; i++) {
    //        lines[i].update();
    //        lines[i].render();
    //      }   
    //      makeParticles();
    //    }

    if (doText) {
      fill(0);
      if (sceneIndex<3) {
        textFont(fontBig);
        text(pieces[sceneIndex], width/2-screenWidth*screenCount/2+screenWidth, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth*2, screenHeight);
      }
      if (sceneIndex>=3 && sceneIndex<=11) {
        textFont(fontMedium);
        text(pieces[3], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
      }
      if (sceneIndex==13) { //when your brain guesses right,
        textFont(fontBig);
        text(pieces[8], width/2-screenWidth*screenCount/2+screenWidth/2, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth, screenHeight);
      }
      if (sceneIndex==14) {
        textFont(fontBig); //you feel like things are running smoothly
        text(pieces[9], width/2-screenWidth*screenCount/2+screenWidth, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth*2, screenHeight);
        for (int i = 0; i<screenCount; i++) { 
          lines[i].lerpVal = .04;
          lines[i].tpos.y = height/2;
        }
      }
      if (sceneIndex==15) {
        textFont(fontBig); //but sometimes it messes up
        text(pieces[10], width/2-screenWidth*screenCount/2+screenWidth, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth*2, screenHeight);
        for (int i = 0; i<screenCount; i++) { 
          lines[i].lerpVal = .04;
          lines[i].tpos.y = 0;
        }
      }
      if (sceneIndex==17) {
        for (int i = 0; i<screenCount; i++) { 
          lines[i].tpos.y = height/3;
        }
      }
      if (sceneIndex==18) {
        textFont(fontBig); //scientists call these errors
        text(pieces[12], width/2-screenWidth*screenCount/2+screenWidth, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth*2, screenHeight);
      }
      if (sceneIndex==19) {
        textFont(fontBig); //the brain adapts
        text(pieces[13], width/2-screenWidth*screenCount/2+screenWidth/4, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth/4, screenHeight);
        for (int i = 0; i<screenCount; i++) { 
          lines[i].tpos.y = height/3+(random(0, 1))*20;
        }
      }
      if (sceneIndex==20) {
        textFont(fontBig); //the brain adapts
        text(pieces[13], width/2-screenWidth*screenCount/2+screenWidth/4, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth/4, screenHeight);
        for (int i = 0; i<screenCount; i++) { 
          lines[i].tpos.y = height/3;
        }
      }
      if (sceneIndex==21) {
        textFont(fontMedium); //it learns
        text(pieces[14], lines[0].cx+screenWidth/10, lines[0].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);
        lines[1].tpos.y = height/4;
        lines[2].tpos.y = height/5;
        lines[3].tpos.y = height/6;
      }
      if (sceneIndex==22) {
        textFont(fontMedium); //it learns
        text(pieces[14], lines[0].cx+screenWidth/10, lines[0].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);
        lines[4].tpos.y = height/6;
        lines[5].tpos.y = height/5;
        lines[6].tpos.y = height/4;
        lines[7].tpos.y = height/3; //change this to be more out of whack? or works?
        lines[8].tpos.y = height/2;
      }
      if (sceneIndex==23) {
        textFont(fontMedium); //it learns
        text(pieces[14], lines[0].cx+screenWidth/10, lines[0].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);
        lines[0].tpos.y = height/2;
        lines[1].tpos.y = height/2;
        lines[2].tpos.y = height/2;
        lines[3].tpos.y = height/2;
      }
      if (sceneIndex==24) {
        textFont(fontMedium); //it learns
        text(pieces[14], lines[0].cx+screenWidth/10, lines[0].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);
        for (int j = 4; j<9; j++) {
          lines[j].tpos.y = height/2;
        }
      }
      if (sceneIndex>=25 && sceneIndex<28) { //involves brain areas like the hippocampus
        textFont(fontMedium);
        lines[0].tpos.y = height/2;
        lines[1].tpos.y = height/2;
        lines[2].tpos.y = height/2;
        text(pieces[15], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
      }
      if (sceneIndex==26) {
        textFont(fontSmall);
        lines[3].index = 1; //hippo
        lines[3].imgPos.x = 0;
        lines[3].tpos.y = height/3;
        //        lines[3].text = pieces[16];
        text(pieces[16], lines[3].cx+screenWidth/10, lines[3].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);        
        lines[3].timgPos.x = screenWidth*2-10;
        lines[3].timgPos.y = screenHeight;
      }
      if (sceneIndex==27) {
        lines[3].timgPos.x = screenWidth;
      }
      if (sceneIndex==28) {
        textFont(fontMedium);
        text(pieces[17], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        textFont(fontSmall);
        lines[4].index = 2; //hippo
        lines[4].imgPos.x = 0;
        lines[4].tpos.y = height/3;
        //        lines[3].text = pieces[16];
        text(pieces[18], lines[4].cx+screenWidth/10, lines[4].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);        
        lines[4].timgPos.x = screenWidth*2-10;
        lines[4].timgPos.y = screenHeight;
      }
      if (sceneIndex==29) {
        textFont(fontMedium);
        text(pieces[17], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        //        textFont(fontSmall);        
        //            text(pieces[18], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        lines[4].timgPos.x = screenWidth;
      }

      if (sceneIndex==30) {
        textFont(fontMedium); //learning new things
        text(pieces[19], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        //These areas are active both when we're forming memories and when we're making decisions based on those memories.
      }
      if (sceneIndex==31) {
        textFont(fontMedium); //and making decisions
        text(pieces[19], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);

        text(pieces[20], lines[6].cx, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        //These areas are active both when we're forming memories and when we're making decisions based on those memories.
      }
      if (sceneIndex==32) {
        textFont(fontMedium); //learning and deciding
        text(pieces[19], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        text(pieces[20], lines[6].cx, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        //These areas are active both when we're forming memories and when we're making decisions based on those memories.
        lines[3].topacity.x = 50;
        lines[4].topacity.x = 50;
      }
      if (sceneIndex==33) {
        textFont(fontMedium); //learning and deciding
        text(pieces[19], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        lines[3].topacity.x = 255;
        lines[4].topacity.x = 255;
        text(pieces[20], lines[6].cx, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
      }     
      if (sceneIndex==34) {
        textFont(fontMedium); //learning and deciding
        text(pieces[19], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        text(pieces[20], lines[6].cx, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        //These areas are active both when we're forming memories and when we're making decisions based on those memories.
        lines[3].topacity.x = 50;
        lines[4].topacity.x = 50;
      }
      if (sceneIndex==35) {
        textFont(fontMedium); //learning and deciding
        text(pieces[19], width/2-screenWidth*screenCount/2+10, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
        lines[3].topacity.x = 255;
        lines[4].topacity.x = 255;
        text(pieces[20], lines[6].cx, lines[0].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
      }  
      if (sceneIndex==36) {
        textFont(fontSmall); //learning and deciding
        text(pieces[21], lines[5].cx+screenWidth/10, lines[5].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);
        lines[5].tpos.y = height/5;
      }   
      if (sceneIndex==37) {
        textFont(fontSmall); //learning and deciding
        text(pieces[22], lines[8].cx+screenWidth/10, lines[8].pos.y+screenHeight/3, screenWidth-10, screenHeight-10);
        lines[8].tpos.y = height/6;
      }  
      if (sceneIndex==38) {
        //      Some researchers measure brain activity through functional magnetic resonance imaging, or fMRI
        //to get images to disappear
        lines[4].timgPos.x = 0;
        lines[3].timgPos.x =0;
        lines[4].timgPos.y = 0;
        lines[3].timgPos.y = 0;
        lines[3].tpos.y = height/1.4;
        lines[4].tpos.y = height/1.4;
        textFont(fontSmall);
        //  "fMRI uses a giant magnet to track blood flow in the brain",
        //WRONG TEXT
        text(pieces[23], lines[6].cx+screenWidth/10, lines[6].pos.y+screenHeight/7, screenWidth*2-10, screenHeight-10);
      }   
      if (sceneIndex==39) {
        lines[8].tpos.y = height/1.4;
        lines[0].tpos.y =0;
        lines[1].tpos.y = 0;
        lines[2].tpos.y = 0;
        lines[3].tpos.y = 0;
        lines[4].tpos.y = 0;
        lines[5].tpos.y = 0;

        //        lines[0].tpos.y = height/1.4;
        //        lines[1].tpos.y = height/1.4;
        //        lines[2].tpos.y = height/1.4;

        noFill();
        smooth();
        strokeWeight(2);
        stroke(100, 20);
        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, -PI/2, PI*1.5/3);
        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, PI / 2, 3 * PI / 2);
        //      }
        //      if (sceneIndex==40) {
        textFont(fontSmall);
        //"fMRI uses a giant magnet to track blood flow in the brain",
        text(pieces[24], lines[6].cx+screenWidth/10, lines[6].pos.y+screenHeight/5, screenWidth*2-10, screenHeight-10);
      }
      if (sceneIndex==40) {
        noFill();
        smooth();
        strokeWeight(2);
        stroke(100, 20);
        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, -PI/2, PI*1.5/3);
        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, PI / 2, 3 * PI / 2);

        lines[8].tpos.y = height/2;
        text(pieces[25], lines[6].cx+screenWidth/10, lines[6].pos.y+screenHeight/5, screenWidth*2-10, screenHeight-10);
      }
      if (sceneIndex==41) {
        noFill();
        smooth();
        strokeWeight(1);
        stroke(100, 20);
        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, -PI/2, PI*1.5/3);
        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, PI / 2, 3 * PI / 2);
        //or disappear?
        //        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[3].imgPos.y, -PI/2, PI*1.5/3);
        //        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[3].imgPos.y, PI / 2, 3 * PI / 2);

        text(pieces[26], lines[6].cx+screenWidth/10, lines[6].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
      }
      if (sceneIndex==42) {
        noFill();
        smooth();
        //        strokeWeight(0);
        stroke(100, 20);
        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, -PI/2, PI*1.5/3);
        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, PI / 2, 3 * PI / 2);
        background(360);
        fill(360);
        stroke(0);
        rect(width/2-(screenWidth*screenCount)/2, 0, img.width+screenWidth/2+22, img.height);
        image(backgroundTwo, width/2, height/2-140);
        for (int i = 0; i< screenCount; i++) {
          lines[i].update();
          lines[i].render();
          line(lines[i].cx, 0, lines[i].cx, height);
        }   
        makeParticles();
      }
      //      if (sceneIndex==43) {
      //        noFill();
      //        smooth();
      //        strokeWeight(0);
      //        stroke(100, 20);
      //        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, -PI/2, PI*1.5/3);
      //        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, PI / 2, 3 * PI / 2);
      //        text(pieces[27], lines[6].cx+screenWidth/10, lines[6].pos.y+screenHeight/5, screenWidth*3-10, screenHeight-10);
      //      }
      if (sceneIndex==43) {
        for (int i = 0; i<lines.length;i++) {
          lines[i].tpos.y = height/2+100;
        }
      }
      if (sceneIndex==44) {
        noFill();
        smooth();
        strokeWeight(1);
        stroke(100, 20);
        arc(width/2+140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, -PI/2, PI*1.5/3);
        arc(width/2-140, height/5+40, screenWidth*screenCount/2, lines[8].pos.y+50, PI / 2, 3 * PI / 2);

        textFont(fontMedium);
        text(pieces[27], width/2-screenWidth*screenCount/2+screenWidth, lines[0].pos.y+screenHeight/5, screenWidth*screenCount-screenWidth*2, screenHeight);
      }
      if (sceneIndex==45) {
        normal=false;
        vid = true;
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
// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void newScene() {
  for (int i = 0; i<lines.length; i++) {
    if (sceneIndex == 1) {
      lines[i].tpos.y = height/3;
    }
    if (sceneIndex == 3) {
      lines[i].tpos.y = 0;
    }
  }
}
void smallText() {
  textFont(fontSmall);
  for (int i = 3; i<lines.length; i++) {
    lines[i].textWidth = screenWidth;
  }
  if (sceneIndex==4) {
    lines[3].tpos.y = height/5;
    lines[5].tpos.y = height/4;
    lines[8].tpos.y = height/3;
  }
  if (sceneIndex==5) {
    lines[5].text = pieces[4]; //where to look
  }
  if (sceneIndex==6) {
    lines[3].text = pieces[4];
  }
  if (sceneIndex==7) {
    lines[8].text = pieces[4];
    lines[4].text = pieces[4];
  }

  if (sceneIndex==8) {
    lines[6].text = pieces[5]; //how to walk
    lines[7].text = pieces[5];
  }
  if (sceneIndex==9) {
    lines[6].text = pieces[5]; //how to walk
    lines[7].text = pieces[5];
    lines[6].lerpVal = .009;
    lines[7].lerpVal = .006;
    if (lines[6].pos.y>height/3-300) { //so they walk like feet together
      lines[7].lerpVal = .013;
    }
    if (lines[7].pos.y>height/3-200) { //so they walk like feet together
      lines[6].lerpVal = .013;
      lines[7].lerpVal = .006;
    }
    if (lines[6].pos.y>height/3-100) { //so they walk like feet together
      lines[7].lerpVal = .013;
      //              lines[7].lerpVal = .006;
    }

    lines[6].tpos.y = height/3;
    lines[7].tpos.y = height/3;
  }
  if (sceneIndex==10) {
    lines[8].text = pieces[6]; //and how to talk
    lines[8].tpos.y = 0;
  }
  if (sceneIndex==11) {
    lines[8].text = pieces[6]; //and how to talk
    lines[6].lerpVal = .03;
    lines[7].lerpVal = .03;
    lines[7].text = pieces[7]; //mumble
    lines[6].text = pieces[7]; //mumble
    lines[5].text = pieces[7]; 
    lines[4].text = pieces[7];
    lines[3].text = pieces[7];

    lines[7].tpos.y = 0;
    lines[6].tpos.y = 0;
    lines[5].tpos.y = 0;
    lines[4].tpos.y = 0;
    lines[3].tpos.y = 0;
  }
  if (sceneIndex==15) {
    lines[4].tpos.y = height/2-100;
    lines[4].text = pieces[11];
    lines[4].textWidth = screenWidth;
  }
  if (sceneIndex==16) {
    lines[4].tpos.y = height/2-100;
    lines[4].text = pieces[11]; //nobodys perfect
    lines[4].textWidth = screenWidth;
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
  x = height/3;

  //  x = passYPos;
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

      stroke(0);
      strokeWeight(.2);


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

