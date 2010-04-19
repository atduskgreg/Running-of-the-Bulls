#include <Stepper.h>
#define STEPS 200
#include <Servo.h>

int leftPin = 2;
int rightPin = 3;

int servoPin = 5;
Servo servo;
int servoPosition = 90;

int enablePin1 = 12;
int enablePin2 = 7;

Stepper stepper(STEPS, 11, 10,9,8);

void setup(){
  digitalWrite(enablePin1, HIGH);
  digitalWrite(enablePin2, HIGH);
  stepper.setSpeed(120);
  servo.attach(servoPin);
  servo.write(90);
}

void loop(){
  stepper.step(1);
  moveServoFromJoystiq();
}

void moveServoFromJoystiq(){
  if(digitalRead(leftPin) == 1 && (servoPosition >= 0)){
    servoPosition = servoPosition - 1;
  } 

  if(digitalRead(rightPin) == 1 && (servoPosition <= 180)){
    servoPosition = servoPosition + 1;
  }

  Serial.println(servoPosition);
  servo.write(servoPosition);
}

