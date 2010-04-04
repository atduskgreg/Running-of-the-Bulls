#ifndef BULL_H
#define BULL_H
 
#include <WProgram.h> //It is very important to remember this!
 
class Bull {
public:
        Bull(int pin);
        ~Bull();
        void move();
        void setLeftNeighbor(Bull lNeighbor);
        void setRightNeighbor(Bull rNeighbor);
        int getPosition();
};
 
#endif