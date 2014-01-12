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

  float lineLength;
  float hourly;

  Line() {
  }


  void update() {
    pos.x = lerp(pos.x, tpos.x, .01);//0.1);
    pos.y = lerp(pos.y, tpos.y, .01);//0.1);
    float lineLength;
    float hourly;
  }


  void render() {
    pushMatrix();
    translate(cx, cy);
    rotate(hourly);
    point(pos.x, pos.y);

//    ellipse(pos.x, pos.y, lineLength, lineLength);
    popMatrix();
  }
}

