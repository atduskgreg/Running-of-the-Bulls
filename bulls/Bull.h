#ifndef BULL_H
#define BULL_H
 
#include <WProgram.h> //It is very important to remember this!

 
class Bull {
public:
        Bull(int pin);
        Bull();
        ~Bull();
        void move();
        void setLeftNeighbor(Bull *lNeighbor);
        void setRightNeighbor(Bull *rNeighbor);
        int getPosition();
        void setPosition(int p);
        void calculateDirection();
        int distanceToLeftNeighbor();
        int distanceToRightNeighbor();
        void reverseDirection();
        int currentDirection;  //-1 being left, 0 being straight, 1 being right
        int currentPosition;
        void noLeftNeighbor();
        void noRightNeighbor();
private:
        Bull *leftNeighbor;
        Bull *rightNeighbor;
        Servo servo;
        boolean hasLeftNeighbor;
        boolean hasRightNeighbor;

};
 
#endif
