import processing.serial.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
Serial myPort;

int closedPos = 90;
int openedPos = 00;

boolean firstContact = false;

void setup(){

  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();  

  printArray( Serial.list() );
  myPort = new Serial(this, Serial.list()[15], 9600);

}

void draw(){
     
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(i + ":" +faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
           
  if(faces.length > 0) {
      camCover(true);
  } else {
      camCover(false);
  }
  
}

void camCover(boolean state) {
  if(state) {
     myPort.write(closedPos);
  } else {
     myPort.write(openedPos);
  }
} 

void captureEvent(Capture c) {
  c.read();
}

void serialEvent( Serial myPort ){
  int inByte = myPort.read();
  
  if(firstContact == false){
    if(inByte == 'A'){
      myPort.clear();
      firstContact = true;
      println("Handshake OK");
      myPort.write('A');
    }
  }
  else {
    println("RX:" + inByte);
  }
}
