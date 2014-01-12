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
  float otherx;
  float othery;

  float somethingX;
  float somethingY;

  float lineLength;
  float hourly;
  PVector lineVector = new PVector();
  PVector tLineVector = new PVector();
  float cos;
  PVector alongWidth = new PVector();
  PVector talongWidth = new PVector();
  Line() {
  }


  void update() {
    pos.x = lerp(pos.x, tpos.x, .01);//0.1);
    pos.y = lerp(pos.y, tpos.y, .01);//0.1);
    
    lineVector.x = lerp (lineVector.x, tLineVector.x, .1);
    alongWidth.x = lerp (alongWidth.x, talongWidth.x, .1);
    float lineLength;
    float hourly;
    float cos;
  }


  void render() {
    pushMatrix();
    translate(cx, cy);
    rotate(hourly);
    point(pos.x, pos.y);
//    line(pos.x, pos.y, lineVector.x, pos.y);
//    ellipse(pos.x, pos.y, lineLength, lineLength);
    popMatrix();
//    pushMatrix();
//    translate(otherx, othery);
//    rotate(cos);
    line(alongWidth.x, pos.y, alongWidth.x, lineVector.x);
//    popMatrix();
  }
}

