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
Atom cl;
Spring NaO;
Spring NaH;
Spring OH;

void settings() {
    fullScreen();
}

void setup() {
    system = new Physics();
    cmusr = createFont("CMU Serif Roman.ttf", 36);
    na = new Atom(width / 10 * 1, height / 2, 50, 11, 12, 11, "Na");
    o = new Atom(width / 10 * 2.28, height / 2, 50, 8, 8, 8, "O");
    h = new Atom(width / 10 * 3.3, height / 2, 50, 1, 0, 1, "H");
    //cl = new Atom(width/10*6, height/2, 30, 17, 20, 17, "Cl");
    NaO = system.makeSpring(na.atom, o.atom);
    OH = system.makeSpring(o.atom, h.atom);
    NaH = system.makeSpring(na.atom, h.atom);
    orientation(LANDSCAPE);
}

void draw() {
    background(189, 211, 255);
    ellipseMode(CENTER);
    textAlign(CENTER, CENTER);
    textFont(cmusr);
    
    if (mousePressed) {
        NaO.a().position().set(mouseX, mouseY);
        na.atom.velocity().set(mouseX - pmouseX, mouseY - pmouseY);
        
    }
        final float time = 1.0f / frameRate;
        system.step(time);
        
        na.show();
        o.show();
        h.show();
        
    }
        