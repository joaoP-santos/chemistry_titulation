import java.util.Random;
import teilchen.behavior.*;
import teilchen.*;
import teilchen.test.*;
import teilchen.util.*;
import teilchen.integration.*;
import teilchen.examples.*;
import teilchen.cubicle.*;
import teilchen.force.*;
import teilchen.wip.*;
import teilchen.constraint.*;

Physics system;
PFont cmusr;
Atom na;
Atom o;
Atom h;
Atom h1;
Atom cl;
Spring NaO;
Spring NaH;
Spring OH;
Spring HCl;
backgroundAtom[] backgroundAtoms = new backgroundAtom[100];
Random rand = new Random();
void settings() {
    fullScreen();
}

void setup() {
    system = new Physics();
    cmusr = createFont("CMU Serif Roman.ttf", 36);
    na = new Atom(width / 10 * 1, height / 2, 50, 11, 12, 11, "Na");
    o = new Atom(width / 10 * 2.5, height / 2, 50, 8, 8, 8, "O");
    h = new Atom(width / 10 * 3.7, height / 2, 50, 1, 0, 1, "H");
    h1 = new Atom(width / 10 * 6, height / 2, 50, 1, 0, 1, "H");
    cl = new Atom(width/10*7.5, height/2, 50, 17, 20, 17, "Cl");
    NaO = system.makeSpring(na.atom, o.atom);
    OH = system.makeSpring(o.atom, h.atom);
    NaH = system.makeSpring(na.atom, h.atom);
    HCl = system.makeSpring(cl.atom, h1.atom);
    NaO.strength(600);
    OH.strength(50);
    NaH.strength(10);
    HCl.strength(60);
    orientation(LANDSCAPE);
    Box limits = new Box();
    limits.min().set(0, 0, 0);
    limits.max().set(width, height, 0);
    system.add(limits);  
    
    for(int i = 0; i < 100; i++) {
      int r = rand.nextInt(0, 2);
      backgroundAtom atom = null;
      if(r == 0) {
        atom = new backgroundAtom(random(0, width), random(0, height), rand.nextInt(20), 8, 8, 8, "");
      } else if (r == 1) {
        atom = new backgroundAtom(random(0, width), random(0, height), rand.nextInt(20), 1, 0, 1, "");
      } else if (r == 2) {
        atom = new backgroundAtom(random(0, width), random(0, height), rand.nextInt(20), 1, 0, 1, "");
      }
      Wander mWander = new Wander();
      atom.atom.behaviors().add(mWander);
    /* a motor is required to push the particle forward - wander manipulates the direction the particle is pushed
     in */
      Motor mMotor = new Motor();
      mMotor.auto_update_direction(true);
      /* the direction the motor pushes into is each step automatically set to the velocity */
      mMotor.strength(rand.nextInt(20));
      atom.atom.behaviors().add(mMotor);
      backgroundAtoms[i] = atom;
    }
    
}

void draw() {
    background(189, 211, 255);
    ellipseMode(CENTER);
    textAlign(CENTER, CENTER);
    textFont(cmusr);
    
    if (mousePressed) {
      if(mouseX < width/2) {
        NaO.a().position().set(mouseX, mouseY);
        na.atom.velocity().set(mouseX - pmouseX, mouseY - pmouseY);
      }
      else if (mouseX > width/2) {
        HCl.a().position().set(mouseX, mouseY);
        cl.atom.velocity().set(mouseX - pmouseX, mouseY - pmouseY);
      }
    }
        final float time = 1.0f / frameRate;
        system.step(time);
         for (backgroundAtom atom : backgroundAtoms) {
          atom.show();
        }
        strokeWeight(2);
        na.show();
        o.show();
        h.show();
        h1.show();
        cl.show();
        strokeWeight(0);
      
    }
        
