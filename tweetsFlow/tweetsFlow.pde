//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}

int numincsv = 61;
PFont font;
PFont font2;
int fontSize = 12;
int fontSize2 = 18;

String pieces;
String apes;
String[] sectiond;

Line [] lines;

String[] tweets = new String [numincsv];
int cx, cy;

//boolean h0, h1, h2, h3 =false;
boolean h, d, n = false;

int thiswidth= 1200; //(1440 x 900)
int thisheight = 500; //1920 x 1080
float yspace=thisheight/5.1;
float xspace = thiswidth/8; 
int radiv = 6;
int marginl = radiv*35;
int margint=radiv*18;

PImage img;
float x = 800;
int offsetX;
//float lerpVal=0;
//float valLerp;

int numShowing = 5;
int initialShowing = 1;
int indexN = 1;
int numFrames = 12;  // The number of frames in the animation
float maxTweetLength = 0;

void setup() {
  size(thiswidth, thisheight); //size(1500, 750); //100

  colorMode(HSB, 360, 100, 100);
  fill (300);

  smooth();
  font= loadFont("BrainFlower-12.vlw");
  font2 = loadFont("BrainFlower-18.vlw");
  textFont(font2, fontSize2);

  lines = new Line[numincsv]; //have to declare length?DO I HAVE TOOOOOOOOOOOOOOOOOO
  String[] dates = loadStrings ("tweets.csv");
  parse(dates);
}
void parse(String[]dates) {
  for (int i = 1; i<lines.length; i++) {
    String[] pieces = splitLine(dates[i]);
    try {
      if (pieces.length >= 0) {
        Line line = new Line();
        line.tweets = (pieces[0]);
        lines[i]=line;
      }
    }
    catch(Exception e) {
      println("error parsing this: " + pieces[0]);
    }
  }
}



void draw() {
  background(0, 0, 20, 10);

//  frameRate(5);
  for (int i = 1; i< lines.length; i++) {
    if (lines[i] != null) {
      lines[i].update();
      lines[i].render();
    }
  }
  //  initialShowing = numShowing - 3;
  //  numShowing = numShowing + 5;
  //  if (initialShowing > 60) { 
  //    initialShowing = 1;
  //  }
  //  if (numShowing > 60) { 
  //    numShowing = 5;
  //  }
  if (h) {
    show();
  }
  if (!h){
println ("h is false");    
    x = 0;
    numShowing = 2;
    n = false;
  }
}

void show() {
  println ("show");
  maxTweetLength = 0;
  if (n && initialShowing<55 && numShowing<60) {
    x = 0;
    // initialShowing = initialShowing+5;
    numShowing = numShowing+5;
    n = false;
  }
//  else if (initialShowing>55 || numShowing < 60) {
//    initialShowing = 1;
//    numShowing = 5;
//  }
  for (int i = initialShowing; i< numShowing; i++) {
    if (lines[i] != null) {

      //      println ("not null");
      int index = i;
      lines[i].cx = 0; 
      float y = map (i, initialShowing, numShowing, 40, height-20);
      lines[i].cy = y;

      lines[i].tweets = lines[i].tweets;
      offsetX += textWidth(lines[index].tweets);
      if (textWidth(lines[index].tweets)>maxTweetLength) {
        maxTweetLength = textWidth(lines[index].tweets);
      }
      println (maxTweetLength);
      lines[i].tpos.x = x+offsetX;
      lines[i].tpos.y = 0;
      float lerpIt = map (textWidth(lines[index].tweets), 0, maxTweetLength, .000001, .0000001);

      lines[i].lerpVal=  lerpIt;//.00001*offsetX;
      x-=1;
      if (x<-offsetX-10) x = width+10;
      //      offsetX = 0;
    }
  }
}

//void newTweets(){
// numShowing =  numShowing+5;
// initialShowing = initialShowing+5;
//// show();
//}

void keyPressed() {
  if (key=='h') h = !h; 
  if (key=='d') d = !d;
  if (key=='n') n = !n;
}

void mousePressed() {
  initialShowing = 5;
  numShowing = 10;
  x = 0;
  show();
}








String[] splitLine(String line) {
  char[] c = line.toCharArray();
  ArrayList pieces = new ArrayList();
  ArrayList apes = new ArrayList();
  int prev = 0;
  boolean insideQuote = false;
  for (int i = 0; i<c.length; i++) {
    if (c[i]== ',') {
      if (!insideQuote) {
        String s = new String (c, prev, i-prev).trim();
        pieces.add(s);
        prev = i+1;
      }
    } 
    else if (c[i] == '\"') {
      insideQuote = !insideQuote;
    }
  }
  if (prev != c.length) {
    String s = new String(c, prev, c.length-prev).trim();
    pieces.add(s);
  }

  if (c.equals ("NULL")) {
    String s = new String(c, prev, c.length-prev).trim();
    apes.add(s);
  }


  String[] outgoing = new String[pieces.size()];
  String[] outgoing2 = new String[apes.size()];

  pieces.toArray(outgoing);
  apes.toArray(outgoing2);

  return outgoing;
}

