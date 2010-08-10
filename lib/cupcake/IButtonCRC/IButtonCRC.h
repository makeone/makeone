#ifndef IButtonCRC_h
#define IButtonCRC_h

#include "WProgram.h"

class IButtonCRC
{
  public:
    IButtonCRC();
    void update(unsigned char);
	char unsigned getCRC();
    void reset();
  private:
    int crc;
};

#endif