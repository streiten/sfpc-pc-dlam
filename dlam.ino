#include <Servo.h> 
Servo myservo;

int val; 
int ledPin = 13;
int ledState = LOW;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
  establishContact();
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
}

void loop() {
  if (Serial.available() > 0){
    val = Serial.read();
    myservo.write(val);
    Serial.println(val);
  }
}

void establishContact(){
  while( Serial.available() <= 0 ){
    Serial.println("A");
    delay(300);
  }
}
