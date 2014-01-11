

class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector mouse;
  // The Mover's maximum speed
  float topspeed;
  
  float hue;
  PVector radius;
  float topRadius;
  float other;

  Mover() {
    // Start in the center
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    topspeed = 5;
    
    topRadius = 200;
    hue = 2;
    radius = new PVector(60,60);
    other = 20;
  }

  void update() {
    
    // Compute a vector that points from location to mouse
//    PVector mouse = new PVector(mouseX,mouseY);

    mouse = new PVector(mouseX,mouseY);
    PVector acceleration = PVector.sub(mouse,location);
    // Set magnitude of acceleration
    //acceleration.setMag(0.2);
    acceleration.normalize();
    acceleration.mult(0.1);
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);

   if (frameCount>200&&frameCount<4000){
//     topspeed =  .1;
//    velocity.limit(topspeed);
     location.x = width/2;
//     location.y = height/2;
     location.y = random(height/2+50, height/2-200);

     other = 1;   
   }
    // Location changes by velocity
    location.add(velocity);
    
    radius.x = lerp(50,100,.2);
    radius.y = lerp(50,100,.2);
    
    hue=hue++;
  }

  void display() {
    stroke(200+random(1,20), 100,100,20);
    strokeWeight(10);
    fill(360, 80);
    ellipse(location.x,location.y, radius.x+other, radius.y+other);
  }

}



