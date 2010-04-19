#include <Servo.h>

int leftPin = 2;
int rightPin = 3;
int servoPin = 5;
Servo servo;

int servoPosition = 90;

void setup(){
  Serial.begin(9600);
  servo.attach(servoPin);
  servo.write(90);
}

void loop(){
 if(digitalRead(leftPin) == 1 && (servoPosition >= 0)){
   servoPosition = servoPosition - 1;
 } 
 
 if(digitalRead(rightPin) == 1 && (servoPosition <= 180)){
   servoPosition = servoPosition + 1;
 }
 
 Serial.println(servoPosition);
 servo.write(servoPosition);
 delay(1);
}
