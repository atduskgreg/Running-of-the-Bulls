#include "Bull.h" //include the declaration for this class
#include <Servo.h> 

Servo servo;
Bull leftNeighbor;
Bull rightNeighbor;
int currentPosition; // zero being left, 180 right
int currentDirection; //-1 being left, 0 being straight, 1 being right

int turnThreshold = 30; // should this be setable? so they can be different...

//<<constructor>>
Bull::Bull(int pin){
    servo.attach(pin);
}
 
void Bull::setLeftNeighbor(Bull lNeighbor){
    leftNeighbor = lNeighbor;
}

void Bull::setRightNeighbor(Bull rNeighbor){
    rightNeighbor = rNeighbor;
}

int Bull::getPosition(){
    return servo.read();
}

void Bull::calculateDirection(){
   if(distanceToLeftNeighbor < turnThreshold){
       currentDirection = 1; // right
   } else if(distanceToRightNeighbor < turnThreshold){
       currentDirection = -1; // left
   } /* else {
       currentDirection = 0; // straight
   } */
}

void Bull::move(){
    calculateDirection();
    servo.write(getPosition() + currentDirection);
}

// HELPER FUNCTIONS for Bull::move()
// lN <------> B <----------> rN
// distance to lN = 180-lN.getPostion() + B.getPosition()
// distance to rN = rN.getPosition() + B.getPosition()
int Bull::distanceToLeftNeighbor(){
   // if no left neightbor, we treat 0 as the wall
    if(!leftNeighbor){
        return getPosition();
    } else {
        return ((180 - leftNeighbor.getPosition()) + getPosition());
    }
}

int Bull::distanceToRightNeighbor(){
    // if no right neightbor, we treat 180 as the wall
    if(!rightNeighbor){
        return (180 - getPosition());
    } else {
        return (rightNeighbor.getPosition()) + (180 - getPosition()));
    }
}

//<<destructor>>
Bull::~Bull(){/*nothing to destruct*/}