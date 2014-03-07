class Line {
  String text;
  int textWidth;
  float lerpVal = 0.03;
  //  int screenWidth = 40;
  //  int screenHeight = 100;

  PVector pos = new PVector();
  PVector tpos = new PVector();

  float cx;
  float cy;


  PVector opacity = new PVector();
  PVector topacity = new PVector();

  PVector imgPos = new PVector();
  PVector timgPos = new PVector();
  //  float opacity;

  PVector backImgPos = new PVector();
  PVector tbackImgPos = new PVector();


  int index = 1;
  PImage img;
  //  PImage background;
  Line() {
  }


  void update() {
//    lerpVal;

    pos.x = lerp(pos.x, tpos.x, lerpVal);//0.1);
    pos.y = lerp(pos.y, tpos.y, lerpVal);//0.1);
    String text;

    opacity.x = lerp(opacity.x, topacity.x, lerpVal);
    //    float opacity;
    //    PImage img;
    int index;
int textWidth;
    imgPos.x = lerp(imgPos.x, timgPos.x, lerpVal);
    imgPos.y = lerp(imgPos.y, timgPos.y, lerpVal);

//    posimgPos.x = lerp(posimgPos.x, postimgPos.x, lerpVal);
//    posimgPos.y = lerp(posimgPos.y, postimgPos.y, lerpVal);


    backImgPos.y = lerp(backImgPos.y, tbackImgPos.y, lerpVal);

    //images[index].resize(screenWidth, 0);
  }


  void render() {

    pushMatrix();
    translate(cx, cy);
    //    println(pos.y+"pos.y");
//    tint(255, opacity.x);  // Apply transparency without changing color

    image(newImages[index], pos.x+screenWidth/2, pos.y+screenHeight/2, imgPos.x, imgPos.y);
    strokeWeight(.5);
    stroke(200);
//    noFill();
    fill(360, 60);
    rect(pos.x, pos.y, screenWidth, screenHeight);
    fill(0);
  text(text, pos.x,pos.y,textWidth-4, screenHeight-4);
//  text(text, pos.x,pos.y,screenWidth-4, screenHeight-4);

//  text("ichiichiichiichiichiichiichi",lines[3].pos.x,lines[3].pos.y,20, 80);

    popMatrix();
  }
}

