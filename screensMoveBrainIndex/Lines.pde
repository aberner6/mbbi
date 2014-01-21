class Line {
  String tweets;
  float lerpVal = 0;

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
    rect(pos.x, pos.y, 40, 100);
//    text(tweets, pos.x, pos.y);
    popMatrix();
  }
}

