//this works with "GetRatePlaySong"
//  VARIABLES
int pulsePin = 0;                 // Pulse Sensor purple wire connected to analog pin 0
int blinkPin = 13;                // pin to blink led at each beat
int fadePin = 5;                  // pin to do fancy classy fading blink at each beat
int fadeRate = 0;                 // used to fade LED on with PWM on fadePin


// these variables are volatile because they are used during the interrupt service routine!
volatile int BPM;                   // used to hold the pulse rate
volatile int Signal;                // holds the incoming raw data
volatile int IBI = 600;             // holds the time between beats, the Inter-Beat Interval
volatile boolean Pulse = false;     // true when pulse wave is high, false when it's low
volatile boolean QS = false;        // becomes true when Arduoino finds a beat.

void setup(){
  pinMode(blinkPin,OUTPUT);         // pin that will blink to your heartbeat!
  pinMode(fadePin,OUTPUT);          // pin that will fade to your heartbeat!
  Serial.begin(115200);             // we agree to talk fast!
  interruptSetup();                 // sets up to read Pulse Sensor signal every 2mS 
  establishContact();  // send a byte to establish contact until Processing responds 
}

void loop() {
  if (Serial.available() > 0){ //if something is there
    if(QS == true) { //from out of box code
      Serial.write(BPM);
      QS=false; //from out of box code
    }
  } 
  delay(20); //wait a bit
}

void establishContact() { //establish contact with Processing
  while (Serial.available() <= 0) {
    Serial.write('A');   // send a capital A
    delay(300);
  }
}

