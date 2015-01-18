/**
 This example demonstrates the `GStick control.

 (c) 2013 Peter Lager
 */
import g4p_controls.*;
import processing.serial.*;

GStick joystick;
int facing = 6;
int dirX, dirY;
float px, py;
float speed;
Serial port;

int SCALE_FACTOR = 800;

public void setup() {
  size(300, 300);
  float ss = 80;
  joystick = new GStick(this, width-ss, height-ss, ss, ss);
  // Change from the default X4 mode (4 position) to the
  // 8 position mode.
  joystick.setMode(G4P.X8);
  strokeWeight(1.5f);
  px = width/2;
  py = height/2;
  port = new Serial(this, "/dev/tty.usbmodem427921", 9600);
}

public void draw() {
  background(255, 255, 230);
  // Calculate current position of arrow
  px = (px + dirX * speed + width) % width;
  py = (py + dirY * speed + height) % height;

  // Draw arrow in current position and rotation
  pushMatrix();
  translate(px, py);
  rotate(facing * PI/4);
  fill(255, 200, 200);
  stroke(160, 32, 32);
  beginShape();
  vertex(-20, -10);
  vertex(-20, 10);
  vertex(30, 0);
  endShape(CLOSE);
  fill(160, 32, 32);
  noStroke();
  ellipse(-6, 0, 10, 6);
  popMatrix();
  
  int m1a,m1b,m2a,m2b;
  m1a = dirX * SCALE_FACTOR;
  m1b = -dirX * SCALE_FACTOR;
  m2a = -dirY * SCALE_FACTOR;
  m2b = dirY * SCALE_FACTOR;
  String msg = "t";
  if (m1a >= 0){
    msg += "+"; 
  } 
  msg += m1a;
  if (m1b >= 0){
    msg += "+"; 
  }
  msg += m1b;
  if (m2a >= 0){
    msg += "+"; 
  }
  msg += m2a;
  if (m2b >= 0){
    msg += "+"; 
  }
  msg += m2b;
  if (m1a != 0 || m1b != 0 || m2a != 0 || m2b !=0){
    println(msg);
    port.write(msg);
  }
  println(msg);
}

public void handleStickEvents(GStick stick, GEvent event) { 
  if (joystick == stick) {
    int pos = stick.getPosition();
    if (pos < 0){ // Stick is in rest position?
      speed = 0;
      dirX = 0;
      dirY = 0;
    } else { // The is not at 
      facing = pos;
      dirX = stick.getStickX();
      dirY = stick.getStickY();
      speed = 0.8;
    }
  }
}

