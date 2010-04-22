#include <Bull.h>
#include <Stepper.h>
#define STEPS 200
#include <Servo.h>
#include <FiniteStateMachine.h>

State attractMode = State(enterAttractMode);
State playMode = State(enterPlayMode);
FSM game = FSM(attractMode);

int leftPin = 2;
int rightPin = 3;

int servoPin = 5;
Servo servo;
int servoPosition = 90;

int enablePin1 = 12;
int enablePin2 = 7;
int stepperPosition = 0;
int stepperDirection = 1;

Stepper stepper(STEPS, 11, 10,9,8);

void setup(){
  digitalWrite(enablePin1, HIGH);
  digitalWrite(enablePin2, HIGH);
  stepper.setSpeed(120);
  servo.attach(servoPin);
  servo.write(90);
  Serial.begin(9600);
}

void loop(){
  switch(game.getCurrentState()){
    case attractMode : doAttractMode(); break;
    case playMode : doPlayMode(); break;
  }
 
  game.update();
}

void moveCarToOrigin(){
  stepper.step(stepperPosition * -1);
  stepperPosition = 0;
}

void enterAttractMode(){
  moveCarToOrigin();
  game.transitionTo(playMode);
}

void doAttractMode(){
  digitalWrite(13, HIGH);
  delay(500);
  digitalWrite(13,LOW);
  delay(500);
}

void enterPlayMode(){
}

void moveStepperForward(){
 stepperPosition += 1;
 stepper.step(1);
}

void doPlayMode(){
  if(stepperPosition >= 5300){
    game.transitionTo(attractMode);
  } else {
    moveStepperForward();
    moveServoFromJoystiq();
  }
}

void moveServoFromJoystiq(){
  if(digitalRead(leftPin) == 1 && (servoPosition >= 0)){
    servoPosition = servoPosition - 1;
  } 

  if(digitalRead(rightPin) == 1 && (servoPosition <= 180)){
    servoPosition = servoPosition + 1;
  }

  servo.write(servoPosition);
}

