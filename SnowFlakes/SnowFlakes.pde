// Class and Arryalist

PImage snowflake;
ArrayList<Flake> f;

void setup() {
  size(800, 800);
  imageMode(CENTER);
  snowflake = loadImage("snowflake.png");  
  f = new ArrayList<Flake>();
  
  for (int i=0; i<6; i++) {
    f.add(new Flake());
  }
}

void draw() {
  background(0);

  if(random(1)<0.07)
    f.add(new Flake());

  for (int i=0; i<f.size(); i++) {
    Flake ff = f.get(i);
    ff.move();
    if (ff.y>height) {
      f.remove(i);
      i--;
    } else {
      ff.display();
    }
  }
}

class Flake {
  float x, y; // position
  float sz; // size
  float speed;
  float alp;
  float ang,astp;

  Flake() {
    x = random(width);
    y = random(-80,-40);
    sz = random(0.1, 0.15)*width;
    speed = random(3.0,5.5);
    alp = random(150, 255);
    ang = random(TWO_PI);
    astp = random(-0.05,0.05);
  }

  void move() {
    y+=speed;
  }

  void display() {
    alp -= .3;
    if(alp<0 || alp>255)astp=-astp;
    ang += astp;
    tint(255,alp); // transpacy when it drop
    pushMatrix();
    translate(x,y);
    rotate(ang);
    image(snowflake, 0, 0, sz, sz);
    popMatrix();
    noTint();
  }
}
