#include <Stepper.h>
#define STEPS 200
#include <Servo.h>
#include <FiniteStateMachine.h>

State attractMode = State(enterAttractMode, doAttractMode, doNothing);
State playMode = State(enterPlayMode, doPlayMode, doNothing);
State evalMode = State(enterEvalMode, doEvalMode, doNothing);

FSM game = FSM(attractMode);

int startButton = 6;
int collisionSwitch = 4;

int leftPin = 3;
int rightPin = 2;

int servoPin = 5;
Servo servo;
int servoPosition = 90;
int leftServoLimit = 30;
int rightServoLimit = 150;

int enablePin1 = 12;
int enablePin2 = 7;
int stepperPosition = 0;
int stepperDirection = 1;

int gameResult = 0; // 0 => fail, 1 => win

Stepper stepper(STEPS, 11, 10,9,8);

void setup(){
  digitalWrite(enablePin1, HIGH);
  digitalWrite(enablePin2, HIGH);
  stepper.setSpeed(120);
  
  servo.attach(servoPin);
  servo.write(90);
  
  pinMode(INPUT, startButton);

  
  Serial.begin(9600);
}

void loop(){
  game.update();
}

void moveCarToOrigin(){
  stepper.step(stepperPosition * -1);
  stepperPosition = 0;
}

void enterAttractMode(){
 servo.write(15);
 Serial.println("rewinding car");
 moveCarToOrigin();
 servo.write(90);
 Serial.println("entering Attract Mode");
  
}

void doAttractMode(){
  if(digitalRead(startButton)){
    game.transitionTo(playMode);
  }
}

void enterPlayMode(){
  Serial.println("entering Play Mode");
}

void moveStepperForward(){
 stepperPosition += 1;
 stepper.step(1);
}

void doPlayMode(){
  // check for collision with player
  if(stepperPosition >= 5300){
    gameResult = 1;
    game.transitionTo(evalMode);
  } else if(digitalRead(collisionSwitch)){
    gameResult = 0;
    game.transitionTo(evalMode);
  } else {
    moveStepperForward();
    moveServoFromJoystiq();
  }
}

void enterEvalMode(){
  Serial.println("entering Eval Mode");
  
}

void doEvalMode(){
  if(gameResult == 0){
    Serial.println("FAIL");
  } else {
    Serial.println("WIN");
  }
  game.transitionTo(attractMode);
}

void moveServoFromJoystiq(){
  if(digitalRead(leftPin) == 1 && (servoPosition >= leftServoLimit)){
    servoPosition = servoPosition - 1;
  } 

  if(digitalRead(rightPin) == 1 && (servoPosition <= rightServoLimit)){
    servoPosition = servoPosition + 1;
  }

  servo.write(servoPosition);
}

void doNothing(){}
