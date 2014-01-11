
Mover mover;

PFont f;
  int gap = 18;

void setup() {
  size(500, 500);
  background(255);
  colorMode(HSB, 360,100,100);
  mover = new Mover();
  smooth();
  // Create the font
  f = createFont("BrainFlower", 48);
  textFont(f);
  textAlign(CENTER, CENTER);
} 

void draw() {
  background(300);
//frameRate(10);
  // Set the left and top margin
  int margin = 10;
  
  if (frameCount<100){
drawHello();
  }
  if (frameCount>100&&frameCount<200){
drawHelloAndWelcome(); 
  }
//  if (frameCount>100&&frameCount<500){
//drawHelloAndWelcome(); 
//  }
   if (frameCount>200&&frameCount<4000){
calmDown(); 
  }
  
  // Update the location
  mover.update();
  // Display the Mover
  mover.display(); 
}
//void drawHelloBig(){
////  frameRate(5);
//  for (int i = 18; i<frameCount/8; i++){
//  textSize(i);
//  text("HELLO", width/2, i+40);
//  }
//}
void drawHello(){
  text("HELLO!", width/2, height/2);
}
void drawHelloAndWelcome(){
  text("Follow Along...", width/2, height/2);
}

void calmDown(){
//  for (int i = 0; i<height; i++){
  text("calm", width/2, height/2);

//for (int j = 100; j<200; j++){
  float j = random (100, 200);
  stroke(j, 100,100,30);
//}
noFill();  

    ellipse(width/2, height/2, frameCount/160, frameCount/160);
//  }
}
