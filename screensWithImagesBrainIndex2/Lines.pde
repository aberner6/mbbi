class Line {
  String tweets;
  float lerpVal = 0.03;
//  int screenWidth = 40;
//  int screenHeight = 100;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();

  float cx;
  float cy;

  Line() {
  }


  void update() {

    pos.x = lerp(pos.x, tpos.x, lerpVal);//0.1);
    pos.y = lerp(pos.y, tpos.y, lerpVal);//0.1);
    String tweets;
  }


  void render() {
    pushMatrix();
    translate(cx, cy);
   image(img, pos.x, pos.y, screenWidth, screenHeight);
//    rect(pos.x, pos.y, screenWidth, screenHeight);
//    text(tweets, pos.x, pos.y);
    popMatrix();
  }
}

