// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float particleX;

  ParticleSystem(PVector location, int x) {
    origin = location.get();
//    x ;
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin, x));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead() || p.location.y>height/2+x) {
        particles.remove(i);
      }
    }
  }
}
