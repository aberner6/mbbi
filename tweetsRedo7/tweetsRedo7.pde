
import rita.*;
RiText line1, line2[], line3[];

int numincsv = 61;
PFont font;
int fontSize = 18;

String pieces;
String apes;

Line [] lines;

String[] tweets = new String [numincsv];
char[] chars;
int cx, cy;
String keyword = "brain";
boolean h, d, n, c, f = false;

int thiswidth= 1500; //(1440 x 900)
int thisheight = 500; //1920 x 1080

PImage img;
//float x = 800;
float x = width;
int offsetX;

int numShowing = 5;
int initialShowing = 1;
int indexN = 1;
float maxTweetLength = 0;
float minTweetLength = 2000;

int imgCount = 9;
PImage[] imgs = new PImage[imgCount];
int r;
int imageCounter = 1;
float moveImgX = -200;
float moveImgY = -200;
int smallPoint, largePoint;

float hr, vr;  // horizontal and vertical radius of the text
float textHeight;
float textRectWidth;

void setup() {
  size(thiswidth, thisheight); //size(1500, 750); //100
  noStroke();

  for (int j = 1; j < imgs.length; j++) {
    imgs[j] = loadImage("img"+j+".jpg");
    imgs[j].resize(160, 120);
  }
  //  img = loadImage("img1.jpg");
  colorMode(HSB, 360, 100, 100);

  smooth();
  font= loadFont("Helvetica-Light-18.vlw");
  textFont(font, fontSize);
   textHeight = textAscent()+textDescent();
  RiText.defaultFont("Helvetica-Light", 18);
  RiText.defaults.showBounds = true;

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



        line1 = new RiText(this, pieces[0], 64, 100); // lines
        line2 = line1.splitWords(); // words
        line1.y = 150;
        line3 = line1.splitLetters(); // letters




          line.chars = pieces[0].toCharArray();
        //        chars = pieces[0].toCharArray();
        //        println(chars[0]);
        for (int j = 0; j<imgs.length; j++) {
          line.images = imgs[j];
        }
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
  fill(0);


  //  if (d && imageCounter<imgCount) {
  //    imageCounter = imageCounter+1;
  //    d = false;
  //  }
  //  if (imageCounter>=imgCount) {
  //    imageCounter = 1;
  //  }

  //      line1.y = 50; // wiggle
  //      line2[1].y = 100;
  //      line3[line3.length-1].y = 150;
  //
  //      RiText.drawAll();

  for (int i = 1; i< lines.length; i++) {
    if (lines[i] != null) {
      lines[i].update();
      lines[i].render();
    }
  }
  if (h) {
    show();
  }
  if (!h) {
    println ("h is false");    
    x = 0;
    numShowing = 2;
    n = false;
  }
  if (c){
    if (mouseY < lines[numShowing-1].cy+5 && mouseY > lines[numShowing].cy-5){
          println (lines[numShowing-1].tweets+"moving");
    lines[numShowing-1].tpos.y += (40);
    }
      }
}

void show() {
  //  println ("show");
  maxTweetLength = 0;
  minTweetLength = 2000;

  if (n && initialShowing<55 && numShowing<60) {
    x = 0;
    numShowing = numShowing+1;
    n = false;
  }

  for (int i = initialShowing; i< numShowing; i++) {
    if (lines[i] != null) {
      int index = i;

      float y = map (index, numShowing, initialShowing, height-20, numShowing*.08);
      lines[i].cy = y;
      lines[i].tpos.y = 0;

      offsetX += textWidth(lines[index].tweets);
      if (textWidth(lines[index].tweets)>maxTweetLength) {
        maxTweetLength = textWidth(lines[index].tweets);
      }
      if (textWidth(lines[index].tweets)<minTweetLength) {
        minTweetLength = textWidth(lines[index].tweets);
      }
      lines[i].cx = width; 
      lines[i].tpos.x = x-offsetX;
      lines[i].lerpVal= .01;//.00001*offsetX;

      if (!d) {
        x+=1;
        x = -5;
        offsetX = width;
      }
      if (d) {
        x+=1;
        x = -5;
        //        textAlign(CENTER);
        offsetX = 0;
        //        textAlign(CENTER);
      }

      if (c) {
        lines[i].cx = width/2;
        lines[i].tpos.x = 0;
        textAlign(CENTER);
      }
      if (f) {
        lines[i].posImg.x += i*2;
        lines[i].posImg.y = lines[i].pos.y;
      }

    }
  }
}

void keyPressed() {
  if (key=='h') h = !h; 
  if (key=='n') n = !n;
  if (key=='d') d = !d;
  if (key=='c') c = !c;
  if (key=='f') f = !f;
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

