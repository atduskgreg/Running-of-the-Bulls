#include <Stepper.h>
#define STEPS 200
#include <Servo.h>
#include <FiniteStateMachine.h>
#include "Bull.h"

State attractMode = State(enterAttractMode, doAttractMode, doNothing);
State playMode = State(enterPlayMode, doPlayMode, doNothing);
FSM game = FSM(attractMode);


Bull bull1;
Bull bull2;

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
  
  bull1 = Bull(0);
  bull2 = Bull(1);
  bull1.setPosition(30);
  bull2.setPosition(120);
  bull1.setRightNeighbor(&bull2);
  bull1.noLeftNeighbor();
  bull2.setLeftNeighbor(&bull1);
  bull2.noRightNeighbor();
  
  Serial.begin(9600);
}

void loop(){
  if(game.isInState(attractMode)){

    doAttractMode(); 
  } else if(game.isInState(playMode)) {
    doPlayMode();
  }
 
  game.update();
}

void moveCarToOrigin(){
  stepper.step(stepperPosition * -1);
  stepperPosition = 0;
}

void enterAttractMode(){
  Serial.println("entering Attract Mode");
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
  Serial.println("entering Play Mode");
}

void moveStepperForward(){
 stepperPosition += 1;
 stepper.step(1);
}

void doPlayMode(){
  if(stepperPosition >= 5300){
    game.transitionTo(attractMode);
  } else {
    bull1.move();
    bull2.move();
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

void doNothing(){}
