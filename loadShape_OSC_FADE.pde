import oscP5.*;
import netP5.*;
OscP5 oscControl;
NetAddress myRemoteLocation;
boolean a;
boolean b;
boolean c;
boolean fin = false;
boolean inicio = true;
boolean keyPress = false;
boolean on;
float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;
float azimut = 20;
float cont = 0;
float exp;
float result;
float picAlpha;
float myAngle1 = 0;
float myAngle2 = 0;
float myAngle3 = 0;
float oscuridad = 120;
float rotateY = 20;
float resultX = 320;
float resultY = 190;
float yA = 360;
float xA = 72;
float x1 = 0;
float x2 = 0;
float x3 = 0;
int hY = 1920/2;
int numPointsW;
int numPointsH_2pi; 
int numPointsH;
int ptsW, ptsH;
int y1 = 127;
int y2 = 127;
int y3 = 127;
int wX = 1080/2;
PShape circle;
PShape torus;
PShape torus2;
PImage img;
String ip;

public void setup() {
  oscControl = new OscP5(this, 10000);
  myRemoteLocation = new NetAddress("127.0.0.1", 13000);
  ip = oscControl.ip();  
  noStroke();
  sphereDetail(60);
  imageMode(CENTER);
  blendMode(LIGHTEST);
  size(1280, 800, P3D);
  colorMode(HSB);
  img = loadImage("r.jpg");
  circle = createShape(SPHERE, 35);
  circle.setTexture(img);
  torus = loadShape("torus.obj");
  torus2 = loadShape("torus2.obj");
}
void mouseClicked() {
  println("MX: ", mouseX);
  println("MY:  ", mouseY);
  println("-a: ", -xA);
  println("-w", yA);
}
void keyPressed() {
  if (key == '1') {
    a = !a;
  }
  if (key == '2') {  
    b = !b;
  }
  if (key == '3') {
    c = !c;
  }
}
public void draw() {
  noCursor();
  background(0);
  if (keyPressed) {
    if (key == '+' && inicio == true) {
      cont = cont+.7;
      if (cont >= 255) {
        cont = 255;
        inicio = false;
        fin = true;
      }
    } else if (key == '-' && fin == true) {
      cont = cont-.7;
      if (cont <= 0) {
        cont = 0;
        fin = false;
        inicio = true;
      }
    }
  }
  if (x1 > -1 && x1 < 0) { 
    if (x1 > -1 && x1 < -.5) {
      y1 = int(map(x1, -1, -.5, 255, 127));
    } 
    if (x1 > -.5 && x1 < 0) {
      y1 = int(map(x1, -.5, 0, 127, 64));
    }
  }
  if (x1 > 0 && x1 < 1) { 
    if (x1 > 0 && x1 < .5) {
      y1 = int(map(x1, 0, .5, 64, 127));
    }
    if (x1 > .5 && x1 < 1) {
      y1 = int(map(x1, -.5, 1, 127, 255));
    }
  }
  if (x2 > -1 && x2 < 0) { 
    if (x2 > -1 && x2 < -.5) {
      y2 = int(map(x2, -1, -.5, 255, 127));
    } 
    if (x2 > -.5 && x2 < 0) {
      y2 = int(map(x2, -.5, 0, 127, 64));
    }
  }
  if (x2 > 0 && x2 < 1) { 
    if (x2 > 0 && x2 < .5) {
      y2 = int(map(x2, 0, .5, 64, 127));
    }
    if (x2 > .5 && x2 < 1) {
      y2 = int(map(x2, -.5, 1, 127, 255));
    }
  }
  if (x3 > -1 && x3 < 0) { 
    if (x3 > -1 && x3 < -.5) {
      y3 = int(map(x3, -1, -.5, 255, 127));
    } 
    if (x3 > -.5 && x3 < 0) {
      y3 = int(map(x3, -.5, 0, 127, 64));
    }
  }
  if (x3 > 0 && x3 < 1) { 
    if (x3 > 0 && x3 < .5) {
      y3 = int(map(x3, 0, .5, 64, 127));
    }
    if (x3 > .5 && x3 < 1) {
      y3 = int(map(x3, -.5, 1, 127, 255));
    }
  }
  if (oscuridad <= 1) {
    oscuridad = 1;
  }
  if (oscuridad >= 255) {
    oscuridad = 255;
  }
  if (keyPressed) {
    if (key == '+') {
      oscuridad=oscuridad+5;
    }
    if (key == '-') {
      oscuridad=oscuridad-5;
    }
  }

  xA = map(mouseX, 0, width, -width, width);
  yA = map(mouseY, 0, width, -width, width);

  camera();

  ambientLight(180, 255, (y3)*(cont/255), width/2, height/2, 0);

  pushMatrix();

  popMatrix();

  y1++;
  
  pointLight(120, 120, (y1)*(cont/255), mouseX, mouseY, 0);
  if (a) {
  pushMatrix();
  translate(width/2, height/2, 25);
  rotateY(myAngle1);
  tint(y1);
  fill(255, 255, 255, 255);
  blendMode(NORMAL);
  shape(circle);
  circle.setTexture(img);
  popMatrix();
  }
  if (b) {
    pushMatrix(); 
    translate(width/2, height/2, 25);
    colorMode(HSB);
    rotateX(-90);
    rotateZ(myAngle2/150);
    rotateY(myAngle2/10);
    scale(2, 2, 2);
    pointLight(132, 120, y2*(cont/255), 644-width/2, 339-height/2, 0);
    pointLight(132, 120, y2*(cont/255), 644-width/2, -(339-height/2), 0);
    scale(.5, .5, .5);
    blendMode(LIGHTEST);
    shape(torus);
    popMatrix();
  }
  if (c) {
    pushMatrix();
    translate(width/2, height/2, 25);
    colorMode(HSB);
    rotateX((myAngle3/150));
    rotateY((myAngle3/10));
    pointLight(190, 80, y3*(cont/255), 630-width/2, 573-height/2, 0);
    pointLight(190, 80, y3*(cont/255), 605-width/2, -(646-height/2), 0);
    blendMode(LIGHTEST);
    shape(torus2);
    popMatrix();
  }
  myAngle1+=.01+(x1/10);
  
  myAngle2+=(.05+(x2));
  
  if (on == true) {
    myAngle3+=(.01+(x3/5));
  } else {
    myAngle3-=(.01+(x3/5));
  }
}
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("1")== true) {
    x1 = theOscMessage.get(0).floatValue();
    if(a){
    OscMessage mensaje1 = new OscMessage("/vkb_midi/0/note/20");   
    float xS1 =  map(y1, 64, 255, 0, 127);
    mensaje1.add(int(xS1)); 
    oscControl.send(mensaje1, myRemoteLocation); 
    }else{
    OscMessage mensaje1 = new OscMessage("/vkb_midi/0/note/20");  
    mensaje1.add(int(0)); 
    oscControl.send(mensaje1, myRemoteLocation); 
    }
  }
  if (theOscMessage.checkAddrPattern("2")== true) {
    x2 = theOscMessage.get(0).floatValue();
    if(b){
    OscMessage mensaje2 = new OscMessage("/vkb_midi/2/note/30");
    float xS2 =  map(y2, 64, 255, 0, 127);
    mensaje2.add(int(xS2)); 
    oscControl.send(mensaje2, myRemoteLocation); 
    }else{
    OscMessage mensaje2 = new OscMessage("/vkb_midi/2/note/30");  
    mensaje2.add(int(0)); 
    oscControl.send(mensaje2, myRemoteLocation); 
    }
  }
  if (theOscMessage.checkAddrPattern("3")== true) {
    x3 = theOscMessage.get(0).floatValue();
    if (x3 < 0) {
      x3=x3+1;
      on = false;
    } else {
      x3=x3-1;
      on = true;
    }
    if(c){
    OscMessage mensaje3 = new OscMessage("/vkb_midi/4/note/60");  
    float xS3 =  map(y3, 64, 255, 0, 127);
    mensaje3.add(int(xS3));     
    oscControl.send(mensaje3, myRemoteLocation);
    }else{
    OscMessage mensaje3 = new OscMessage("/vkb_midi/4/note/60");  
    mensaje3.add(int(0)); 
    oscControl.send(mensaje3, myRemoteLocation); 
    }
  }
    if (theOscMessage.checkAddrPattern("1")== true) {
    x1 = theOscMessage.get(0).floatValue();
  }
  if (theOscMessage.checkAddrPattern("2")== true) {
    x2 = theOscMessage.get(0).floatValue();
  }
  if (theOscMessage.checkAddrPattern("3")== true) {
    x3 = theOscMessage.get(0).floatValue();
  }

}
