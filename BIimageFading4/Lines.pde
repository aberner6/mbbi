class Line {
  String tweets;
  float lerpVal = 0.03;
//  int screenWidth = 40;
//  int screenHeight = 100;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();

  float cx;
  float cy;
float opacity;
int index = 1;
PImage img;
  Line() {
  }


  void update() {

    pos.x = lerp(pos.x, tpos.x, lerpVal);//0.1);
    pos.y = lerp(pos.y, tpos.y, lerpVal);//0.1);
    String tweets;
    float opacity;
//    PImage img;
int index;
//images[index].resize(screenWidth, 0);

  }


  void render() {
    pushMatrix();
    translate(cx, cy);
    tint(255, opacity);  // Apply transparency without changing color
// images[index].resize(screenWidth,0);
  image( newImages[index],pos.x, pos.y);

fill(255,40);
 rect(pos.x, pos.y, screenWidth, screenHeight);


// image( images[index],pos.x, pos.y,screenWidth, screenHeight);







//   image(img2, pos.x, pos.y, screenWidth, screenHeight);
//    rect(pos.x, pos.y, screenWidth, screenHeight);
    popMatrix();
  }
}
