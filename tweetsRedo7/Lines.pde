class Line {
  String tweets;
  char[] chars;

  float lerpVal = 0;

  PVector pos = new PVector();
  PVector tpos = new PVector();
  PVector posImg = new PVector();
  PVector tposImg = new PVector();
  float cx;
  float cy;

  PImage images;
  String keyword = "brain";
  int secondAlphaFill;
//float textHeight;
float textRectWidth;

  Line() {
  }


  void update() {

    pos.x = lerp(pos.x, tpos.x, lerpVal);//0.1);
    pos.y = lerp(pos.y, tpos.y, lerpVal);//0.1);
    String tweets;
    String chars;
    PImage images;
    posImg.y = lerp(posImg.y, tposImg.y, .004);//0.1);
    posImg.x = lerp(posImg.x, tposImg.x, .004);//0.1);
//float textHeight;
float textRectWidth;
  }


  void render() {
    pushMatrix();
    translate(cx, cy);
    fill(0);
    text(tweets, pos.x, pos.y);
//    fill(0,secondAlphaFill);
//    text(keyword, pos.x, pos.y);

//    text(chars[0], posImg.x, posImg.y);
//        image(images, posImg.x, posImg.y); //increment x and y position according to which number it is in the index
fill (360);
    rect (pos.x-posImg.x*2, posImg.y-textHeight-30, width, textHeight+50); //increment x and y position according to which number it is in the index
//    rect (posImg.x, pos.y, textHeight, width); //increment x and y position according to which number it is in the index

    popMatrix();
//    pushMatrix();
//    image(images, posImg.x, posImg.y); //increment x and y position according to which number it is in the index
//    popMatrix();
  }
}

