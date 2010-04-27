#include <Servo.h>
#include "Bull.h"

Bull bull1;
Bull bull2;
Bull bull3;
Bull bull4;
Bull bull5;

int resetPin = 4;

// bull1 -- bull2 -- bull3 -- bull4 -- bull5
void setup(){
 
  randomSeed(analogRead(0));
  
  bull1 = Bull(10);
  bull2 = Bull(11);
  bull3 = Bull(9);  
  bull4 = Bull(6);
  bull5 = Bull(5);

  bull1.setPosition(random(60, 120));
  bull2.setPosition(random(60, 120));
  bull3.setPosition(random(60, 120));
  bull4.setPosition(random(60, 120));
  bull5.setPosition(random(60, 120));
  
  
  
  bull1.setRightNeighbor(&bull2);
  bull1.noLeftNeighbor();
  
  bull2.setLeftNeighbor(&bull1);
  bull2.setRightNeighbor(&bull3);
  
  bull3.setLeftNeighbor(&bull2);
  bull3.setRightNeighbor(&bull4);
  
  bull4.setLeftNeighbor(&bull3);
  bull4.setRightNeighbor(&bull5);
  
  bull5.setLeftNeighbor(&bull4);
  bull5.noRightNeighbor();
  
  Serial.begin(9600);
}

void loop(){

    bull1.move();
    bull2.move();
    bull3.move();
    bull4.move();
    bull5.move();
    delay(15);
  
/*  Serial.print(bull1.getPosition());
  Serial.print("\t");
  Serial.print(bull2.getPosition());
  Serial.print("\t");
  Serial.println(bull3.getPosition());
  *
 
/*
Serial.print(" [");
if(bull1.hasLeftNeighbor){
Serial.print("y");
} else {
  Serial.print("n");
}
Serial.print("] ");
Serial.print(bull1.getPosition());
Serial.print(" / ");
Serial.print(bull1.distanceToRightNeighbor());

Serial.print(" [");
if(bull1.hasRightNeighbor){
Serial.print("y");
} else {
  Serial.print("n");
}

Serial.print("]");
Serial.print("\t");

Serial.print(" [");
if(bull2.hasLeftNeighbor){
Serial.print("y");
} else {
  Serial.print("n");
}
Serial.print("] ");
Serial.print(bull2.getPosition());
Serial.print(" [");
if(bull2.hasRightNeighbor){
Serial.print("y");
} else {
  Serial.print("n");
}
Serial.print("]");

Serial.print("\t");
Serial.print(" [");
if(bull3.hasLeftNeighbor){
Serial.print("y");
} else {
  Serial.print("n");
}
Serial.print("] ");
Serial.print(bull3.getPosition());
Serial.print(" [");
if(bull3.hasRightNeighbor){
Serial.print("y");
} else {
  Serial.print("n");
}
Serial.println("]");
*/

}
