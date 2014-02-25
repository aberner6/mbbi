// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  int bloodRadius = 5;
  
  Particle(PVector l) {
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-4,1),random(-1,1));

//    velocity = new PVector(random(-4,-3.999),random(-1,-.99));
    location = l.get();
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
  
    fill(360,100,100,lifespan/2);
    ellipse(location.x,location.y,bloodRadius,bloodRadius);
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

