//this works with Arduino file - "GetRate"

import processing.serial.*;
import ddf.minim.*; //from "PlayAFile"

int BPM;
PFont f;

Minim minim; //from "PlayAFile"
AudioPlayer player_1; //changed this to player_1 instead of just player, same for the . //from "PlayAFile"
AudioPlayer player_2; //from "PlayAFile"
AudioPlayer player_3; //from "PlayAFile"

Serial myPort;                       // The serial port
//int[] serialInArray = new int[3];    // Where we'll put what we receive
//int serialCount = 0;                 // A count of how many bytes we receive
//int xpos, ypos;		             // Starting position of the ball
boolean firstContact = false;        // Whether we've heard from the microcontroller

void setup() {
  size(550, 256);  // Stage size
  f = createFont("Arial",16,true);
  
  minim = new Minim(this); //from "PlayAFile"
  //loading each music file in setup //from "PlayAFile"
  player_1 = minim.loadFile("slow.mp3"); //slow: Ice Fortress 
  player_2 = minim.loadFile("normal.mp3"); //normal: Travel Hearts
  player_3 = minim.loadFile("fast.mp3"); //fast: Bossa Bossa

  String portName = "/dev/tty.usbmodem1421";
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  background(255);
  
  textFont(f,16);                 // STEP 4 Specify font to be used
  fill(220,0,0);                        // STEP 5 Specify font color 
  text("Put your finger on the Pulse Sensor to measure your heart rate! <3", 40,120);  // STEP 6 Display Text
}

void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    int heartVal = inByte;
    println(heartVal);
    
    if(heartVal >=0 && heartVal <=60) { //from "PlayAFile"
    player_2.pause();
    player_3.pause();
    //player_1.rewind();
    player_1.play();
  }
  
  if(heartVal >60 && heartVal <100) { //from "PlayAFile"
    player_1.pause();
    player_3.pause();
    //player_2.rewind();
    player_2.play();
  }
  
  if(heartVal > 100) { //from "PlayAFile"
    player_1.pause();
    player_2.pause();
    //player_3.rewind();
    player_3.play();
  }
  
   else if (key == 'q'){ //from "PlayAFile"
   player_1.pause();
   player_2.pause();
   player_3.pause();
  }

    // Send a capital A to request new sensor readings:
    myPort.write('A');
    // Reset serialCount:
    //serialCount = 0;
  }
}
  //void loop(){
  //float heartVal = map(BPM, 0, 200, 0, 100); 
  
  
 
 
