// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
boolean b = false;
  int bloodRadius = 5;
  float particleX;
  float particleY;
//  int x;
  Particle(PVector l, int x) {
println(x);

    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-4,1),random(-1,1));
    
//    velocity = new PVector(random(-4,-3.999),random(-1,-.99));
    location = l.get();
    println (l);
    lifespan = 100.0;
  }

  void run() {
    update();
    display();
  }


  // Method to update location
  void update() {
    velocity.add(acceleration);
    
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
//    stroke(255,lifespan);
  noStroke();
//  if (b){
//   particleX = 200;
//  particleY = 200; 
//  }
    fill(360,100,100,lifespan/2);
    ellipse(location.x,location.y-x/5,bloodRadius,bloodRadius);
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

