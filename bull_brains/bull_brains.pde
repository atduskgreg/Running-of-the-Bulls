#include <Servo.h>
#include "Bull.h"

Bull bull1;
Bull bull2;
//Bull bull3 = Bull(11);

// bull1 -- bull2 -- bull3
void setup(){
 
    bull1 = Bull(10);
  bull2 = Bull(11);

  bull1.setPosition(30);
  bull2.setPosition(120);
  
  bull1.setRightNeighbor(&bull2);
  bull1.noLeftNeighbor();
  
  bull2.setLeftNeighbor(&bull1);
  bull2.noRightNeighbor();
  Serial.begin(9600);
}

void loop(){

  bull1.move();
  bull2.move();
  delay(25);
  //bull2.move();
  //bull3.move();
  /*bull1.setPosition(180);
  delay(1000);
  bull1.setPosition(0);
  delay(1000);*/

/*Serial.print("dToWall: ");
Serial.print(bull1.distanceToLeftNeighbor());
Serial.print(" dToR: ");
Serial.print(bull1.distanceToRightNeighbor());


 Serial.print("\t\t");
 Serial.print("dToL: ");
 Serial.print(bull2.distanceToLeftNeighbor());
 Serial.print(" dToWall: ");
Serial.println(bull2.distanceToRightNeighbor());
*/
Serial.print(bull1.getPosition());
Serial.print("\t");
Serial.println(bull2.getPosition());

 // Serial.print("\t");
  /* Serial.print(bull3.getPosition());
  Serial.println();*/
  //delay(20);
  //delay(75);
}
