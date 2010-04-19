#include <Stepper.h>

#define STEPS 200

int enablePin1 = 12;
int enablePin2 = 7;

Stepper stepper(STEPS, 11, 10,9,8);

void setup(){
  digitalWrite(enablePin1, HIGH);
  digitalWrite(enablePin2, HIGH);
  stepper.setSpeed(120);
  
}

void loop(){
  stepper.step(1);
}
