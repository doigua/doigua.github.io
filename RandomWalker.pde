// Random generator;

import processing.sound.*;
AudioIn input;
Amplitude loudness;

PVector mov;

class Walker{
  
  float x, y; // position of eyeball
  float xv, yv; // ramdom position of eyeball
  float ox1, ox2; // point original of eye
  float by1, by2, by3, by4; // control line of bezier
  float taile; // size of eye
  float ball1, ball2; // size of eye ball
  
  // random movement
  float rx, ry;
  float c;
  float t;
  float t2;
  
  Walker(){
    c = random(240, 255);
    t = 0;
    t2 = 0;
    rx=random(100);
    ry=random(-100,0);
    taile = random(28,35);
    ball1 = random(5,8);
    ball2 = ball1 + 1;
    
  }
  
  float getpox()
  {
    return x;
  }
  
  float getpoy()
  {
    return y;
  }
  
  void step()
  {
    x = noise(t+rx)*width;
    y = noise(t+ry)*height;
    t += 0.005;
  }
  
  void display(){
    
    stroke(0);
    strokeWeight(2);
    fill(c);
    
    line(x-20, y-24, x+10, y+10);
    line(x, y-30, x, y);
    line(x+20, y-24, x-10, y+10);
    
    ox1 = x - taile;
    ox2 = x + taile;
    by1 = map(dist(ox1, 0, ox1, y), 0, height, y+23, y+28);
    by2 = map(dist(ox2, 0, ox2, y), 0, height, y-26, y-36);
    
    bezier(ox1, y, ox1, by1, ox2, by1, ox2, y);
    bezier(ox2, y, ox2, by2, ox1, by2, ox1, y);
    
    /*
    noFill();
    bezier(ox2-3, y-16, ox2-3, by2-4, ox1+3, by2-4, ox1+3, y-16);
    */
    
    xv = map(noise(t2+rx), 0, 1, -24, 24);
    yv = map(noise(t2+ry), 0, 1, -12, 10);
    t2 += 0.003;
    
    mov = new PVector(xv, yv);
    
    fill(0);
    ellipseMode(CENTER);
    ellipse(x+mov.x, y+mov.y, ball1, ball2);
    
  }
  
  void display_stop(){
    
    stroke(0);
    strokeWeight(2);
    fill(c);
    
    line(x-22, y-26, x+10, y+10);
    line(x, y-32, x, y);
    line(x+22, y-26, x-10, y+10);
    
    ellipseMode(CENTER);
    ellipse(x, y, 60, 50);
    
    noStroke();
    fill(0);
    ellipseMode(CENTER);
    ellipse(x, y, ball2, ball2);
  }
}

void fleur(float fl)
  {
      noStroke();
      fill(255,237,79);
      ellipseMode(CENTER);
      ellipse(width/2, height/2, fl*16000, fl*16000);
  }

ArrayList<Walker> w;

void setup(){
  size(1280, 744);
  
  input = new AudioIn(this);
  input.start();
  loudness = new Amplitude(this);
  loudness.input(input);
  
  w = new ArrayList<Walker>();
  for (int i=0; i<20; i++)  // numero de eye
  {
    w.add(new Walker());
  }
}

void draw(){

  frameRate(25);
  background(255, 229, 0);
  fleur(loudness.analyze());
  /*
  stroke(0);
  strokeWeight(2);
  noFill();
  rect(width/2-80, height/2-80, 160, 160);
  */
  
  
  for (int i=0;i<w.size();i++){
    // println(in.left.level());
    Walker tswalker = w.get(i);
    
    /*
    if (tswalker.getpox() < width/2+80 && tswalker.getpox() > width/2-80 
        && tswalker.getpoy() < height/2+80 && tswalker.getpoy() > height/2-80)
    {
      if (in.left.level() > 0.003 || in.right.level() > 0.003)
      {
        println(tswalker.getpox());
        tswalker.display();
        delay(700);
      }
      else
      {
        println("out");
        tswalker.step();
        tswalker.display();
      }
    }

    else
    {
      tswalker.step();
      tswalker.display(); 
    }
    */
    
    if (loudness.analyze() > 0.001)
    {
      if (tswalker.getpox() < width/2+(loudness.analyze()*8000) 
       && tswalker.getpox() > width/2-(loudness.analyze()*8000)
       && tswalker.getpoy() < height/2+(loudness.analyze()*8000) 
       && tswalker.getpoy() > height/2-(loudness.analyze()*8000))
        {
          // println(loudness.analyze());
          tswalker.display_stop();
        }
        else
        {
          // println("out");
          tswalker.step();
          tswalker.display(); 
        }
    }
    else
    {
      println("out");
      tswalker.step();
      tswalker.display();  
    }
  }
  

  strokeWeight(0);
  fill(0);
  rect(0, 0, width, 80);
  rect(0, height-80, width, height);
  rect(0, 0, 80, height);
  rect(width-80, 0, width, height);

}
