//key presses give different views. press h for initial view, 
//then d to simulate trying to control that circle with your brain concentration
//then h again to "bring it all in"
//void keyPressed(){
// if (key=='h') h = !h; 
// if (key=='d') d = !d; 
//
//}

int numincsv = 24;
PFont font;
PFont font2;
int fontSize = 12;
int fontSize2 = 18;

String pieces;
String apes;
String[] sectiond;

Line [] lines;

int[] lineCount = new int [numincsv];
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

int numcircles = 26;
int[] articleCount = new int [numcircles];
//int radius;


float theta = 0.0;
int maxwaves = 5;   // total # of waves to add together
float[] amplitude = new float[maxwaves];   // Height of wave


void setup() {
  size(thiswidth, thisheight); //size(1500, 750); //100

  colorMode(HSB, 360, 100, 100);
  stroke(200);
  fill (100);

  textMode(CENTER);
  smooth();
  font= loadFont("BrainFlower-12.vlw");
  font2 = loadFont("BrainFlower-18.vlw");
  textFont(font, fontSize);

  lines = new Line[numincsv]; //have to declare length?DO I HAVE TOOOOOOOOOOOOOOOOOO
  String[] dates = loadStrings ("lines.csv");
  parse(dates);
}
void parse(String[]dates) {
  for (int i = 1; i<lines.length; i++) {
    String[] pieces = splitLine(dates[i]);
    try {
      if (pieces.length >= 0) {
        Line line = new Line();
        //get wordcount and send to line object
        line.wordCount = int(pieces[0]);

        lines[i]=line;
      }
    }
    catch(Exception e) {
      println("error parsing this: " + pieces[0]);
    }
    println (pieces[0]+"what's the deal");
  }
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

void draw() {
  background(0, 0, 20, 10);

  for (int i = 1; i< lines.length; i++) {
    if (lines[i] != null) {
      lines[i].update();
      lines[i].render();
    }
  }
  if (h) {
    show();
  }
  if (d) {
    degrade();
  }
}

void show() {
  println ("show");
  for (int i = 1; i< lines.length; i++) {
    if (lines[i] != null) {

      println ("not null");

      lines[i].cx = width/2; 
      lines[i].cy = height/2;

      float lineLength = map(lines[i].wordCount, 0, 20, 5, 10);
      lines[i].lineLength = lineLength;
      lines[i].tpos.x = 10;
      //      lines[i].tpos.x = 5*i;
      lines[i].tpos.y = 10;

      float turnBy = map (i, 1, lines.length, 0, TWO_PI)-HALF_PI; //hours+norm(articles[i].minutes, 0, 60)
      lines[i].hourly =turnBy;
    }
  }
}
void degrade() {
  println ("show");
  theta += 0.02;
  for (int i = 1; i< lines.length; i++) {
    if (lines[i] != null) {

      println ("not null");

      lines[i].cx = width/2; 
      lines[i].cy = height/2;

      float lineLength = map(lines[i].wordCount, 0, 20, 5, 10);
      lines[i].lineLength = lineLength;
      lines[i].tpos.x = random(20, (frameCount/10));
      lines[i].tpos.y = 10;

      float turnBy = map (i, 1, lines.length, 0, TWO_PI)-HALF_PI; //hours+norm(articles[i].minutes, 0, 60)
      lines[i].hourly =turnBy;

//      lines[i].tLineVector.x = random(20, (frameCount/10));
      lines[i].tLineVector.x = random(20, 100);

      float thisPos = map(i, 0, 25, 0, width);
      lines[i].talongWidth.x = thisPos;
      //      lines[i].otherx = 5; 
      //      lines[i].othery = 0;
      //          float x = theta;
      //      float turnCos = map (i, 1, lines.length, 0, (sin(x)*amplitude[1]))-HALF_PI; //hours+norm(articles[i].minutes, 0, 60)
      //      lines[i].cos =turnCos;
    }
  }
}

void keyPressed() {
  if (key=='h') h = !h; 
  if (key=='d') d = !d;
}

