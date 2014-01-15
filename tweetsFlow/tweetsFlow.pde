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
boolean h, d = false;

int thiswidth= 500; //(1440 x 900)
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

  frameRate(10);
  for (int i = 1; i< lines.length; i++) {
    if (lines[i] != null) {
      lines[i].update();
      lines[i].render();
    }
  }
  if (h) {
    show();
  }
  //  if (d) {
  //    degrade();
  //  }
}

void show() {
  println ("show");
  for (int i = 1; i< 5; i++) {
    if (lines[i] != null) {

      println ("not null");
      int index = i;
      lines[i].cx = 0; 
      //      lines[i].cy = height/2;
      float y = map (i, 0, 5, 20, height);
      lines[i].cy = y;
      
      lines[i].tweets = lines[i].tweets;
      offsetX += textWidth(lines[index].tweets);
      lines[i].tpos.x = x+offsetX;
      lines[i].tpos.y = 0;
      
//  float lerping = 0;
//  float valLerp = map(lerping, .004, .1, 0, offsetX);
      lines[i].lerpVal= .00001*offsetX;
//      lines[i].lerpVal = .004;
      x-=1;
      if (x<-offsetX-10) x = width+10;
      offsetX = 0;
    }
  }
}

void keyPressed() {
  if (key=='h') h = !h; 
  if (key=='d') d = !d;
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

