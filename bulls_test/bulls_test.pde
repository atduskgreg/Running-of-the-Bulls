#include <Servo.h>
#include "Bull.h"

Bull bull1;
Bull bull2;
//Bull bull3 = Bull(11);

// bull1 -- bull2 -- bull3
void setup(){
  
  randomSeed(analogRead(0));

  bull1.setPosition(random(0, 180));
  bull2.setPosition(random(0, 180));
  //bull3.setPosition(random(0, 180));

  bull1 = Bull(11);
  bull2 = Bull(10);
  
  bull1.setRightNeighbor(&bull2);
  bull1.noLeftNeighbor();
  
  bull2.setLeftNeighbor(&bull1);
  bull2.noRightNeighbor();
  Serial.begin(9600);
}

void loop(){

  bull1.move();
  bull2.move();
  delay(50);
  //bull2.move();
  //bull3.move();
  /*bull1.setPosition(180);
  delay(1000);
  bull1.setPosition(0);
  delay(1000);*/
  
Serial.print(bull1.getPosition());

 Serial.print("\t");
 Serial.println(bull2.getPosition());
 // Serial.print("\t");
  /* Serial.print(bull3.getPosition());
  Serial.println();*/
  //delay(20);
  //delay(75);
}
