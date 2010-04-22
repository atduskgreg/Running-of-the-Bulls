#include "Bull.h" //include the declaration for this class

int turnThreshold = 30; // should this be setable? so they can be different...

//<<constructor>>
Bull::Bull(){
}

Bull::Bull(int pin){
    servo.attach(pin);
    int ar[] = {-1,1};
    currentDirection = ar[random(2)];
    currentPosition = servo.read();
    Serial.print("cp: ");
    Serial.println(currentPosition);
}
 
void Bull::setLeftNeighbor(Bull *lNeighbor){
    leftNeighbor = lNeighbor;
    hasLeftNeighbor = true;
}

void Bull::noLeftNeighbor(){
  hasLeftNeighbor = false;
}

void Bull::noRightNeighbor(){
  hasRightNeighbor = false;
}

void Bull::setRightNeighbor(Bull *rNeighbor){
    rightNeighbor = rNeighbor;
    hasRightNeighbor = true;
}

int Bull::getPosition(){
  return currentPosition;
}

void Bull::reverseDirection(){
    currentDirection = currentDirection * -1;
}

void Bull::calculateDirection(){
   if(distanceToLeftNeighbor() <= turnThreshold){
       reverseDirection();  
       if(hasLeftNeighbor)
         leftNeighbor->reverseDirection();
   } else if(distanceToRightNeighbor() <= turnThreshold){
       reverseDirection();  
       if(hasRightNeighbor)
         rightNeighbor->reverseDirection();
   } /* else {
       currentDirection = 0; // straight
   } */
}

void Bull::move(){
    calculateDirection();
    currentPosition = currentPosition + currentDirection;
    
    // deal with < 0 or > 180.
    servo.write(currentPosition);
}

// HELPER FUNCTIONS for Bull::move()
// lN <------> B <----------> rN
// distance to lN = 180-lN.getPostion() + B.getPosition()
// distance to rN = rN.getPosition() + B.getPosition()
int Bull::distanceToLeftNeighbor(){
   // if no left neightbor, we treat 0 as the wall
    if(!hasLeftNeighbor){
        return getPosition();
    } else {
        return ((180 - leftNeighbor->getPosition()) + getPosition());
    }
}

int Bull::distanceToRightNeighbor(){
    // if no right neightbor, we treat 180 as the wall
    if(!hasRightNeighbor){
      return (180 - getPosition());
    } else {
        return (rightNeighbor->getPosition() + (180 - getPosition()));
       
    }
}

void Bull::setPosition(int p){
  servo.write(p);
  currentPosition = p;
}

//<<destructor>>
Bull::~Bull(){/*nothing to destruct*/}
