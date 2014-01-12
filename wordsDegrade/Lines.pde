class Line {
  int wordCount;
  float space;
  float lineHeight;
  float px;
  float py;

  PVector pos = new PVector();
  PVector tpos = new PVector();

  float cx;
  float cy;

  float somethingX;
  float somethingY;

  int radius;
  float hoursRadius;
  float hourly;

  boolean hover = false;

  Line() {
  }


  void update() {
    pos.x = lerp(pos.x, tpos.x, .2);//0.1);
    pos.y = lerp(pos.y, tpos.y, .2);//0.1);
  }


  void render() {
    pushMatrix();
    translate(cx, cy);
    ellipse(pos.x, pos.y, 10, 10);
    popMatrix();
  }
}

