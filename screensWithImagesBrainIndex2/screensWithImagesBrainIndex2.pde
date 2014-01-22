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
int fontSize = 12;

String pieces;
String apes;
String[] sectiond;

Line [] lines;

int cx, cy;

//s is show
//n is new screen
//b is screen go back up

boolean d, n, u, p, t = false;

int thiswidth= 1200; //(1440 x 900)
int thisheight = 500; //1920 x 1080

PImage img;

int numShowing = 1;
int initialShowing = 0;

int screenWidth = 40;
int screenHeight = 100;
int whichScreen;
int topMargin = 5;
void setup() {
  size(thiswidth-115, thisheight+screenHeight); //size(1500, 750); //100

  colorMode(HSB, 360, 100, 100);
  fill (300);

  smooth();
  font= loadFont("BrainFlower-12.vlw");
  //  font2 = loadFont("BrainFlower-18.vlw");
  textFont(font, fontSize);

  lines = new Line[numincsv]; //have to declare length?DO I HAVE TOOOOOOOOOOOOOOOOOO
  String[] dates = loadStrings ("tweets.csv");
  parse(dates);
  img = loadImage("brainimg.png");  // Load the image into the program  
//  imageMode(CENTER);
//  thiswidth = img.width;
//  thisheight = img.height;
}
void parse(String[]dates) {
  for (int i = 1; i<lines.length; i++) {
    String[] pieces = splitLine(dates[i]);
    try {
      if (pieces.length >= 0) {
        Line line = new Line();
        //        line.tweets = (pieces[0]);
        lines[i]=line;
      }
    }
    catch(Exception e) {
      println("error parsing this: " + pieces[0]);
    }
  }
}



void draw() {
  background(360);
  image(img, 0, 0, img.width*2/3, img.height*2/3);

//  image(img, width/2, height/2-screenHeight, img.width*2/3, img.height*2/3);

  for (int i = 0; i< lines.length; i++) {
    if (lines[i] != null) {
      lines[i].update();
      lines[i].render();
    }
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
  for (int i = 0; i< 12; i++) {
    if (lines[i] != null) {
      float screenX = map(i, 1, 11, width/2-img.width/4, width/2+img.width/4); 
      lines[i].cx = screenX+screenWidth;

      lines[i].cy = 0; 
      lines[i].tpos.x = 0;
      lines[i].tpos.y = 0;
    }
  }
}
void floatDown() {
  for (int i = 0; i< 12; i++) {
    if (lines[i]!=null){
      float screenX = map(i, 1, 11, width/2-img.width/4, width/2+img.width/4); 
      lines[i].cx = screenX+screenWidth;
      lines[i].cy = 0; 
      lines[i].pos.x = 0;
      lines[i].pos.y = 0;

      lines[i].tpos.x = 0;
      lines[i].tpos.y = height-screenHeight+topMargin;
    }
  }
}
void floatUp() {
  for (int i = 0; i< 12; i++) {
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

