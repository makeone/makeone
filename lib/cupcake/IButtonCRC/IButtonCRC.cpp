/**
     * This is a Java implementation of the IButton/Maxim 8-bit CRC.
     * Code ported from the AVR-libc implementation, which is used
     * on the RR3G end.
     */
#include "WProgram.h"
#include "IButtonCRC.h"

IButtonCRC::IButtonCRC() {
 
 crc = 0;
  
}
                /**
                 * Update the  CRC with a new byte of sequential data.
                 * See include/util/crc16.h in the avr-libc project for a 
                 * full explanation of the algorithm.
                 * @param data a byte of new data to be added to the crc.
                 */
               void IButtonCRC::update(unsigned char data) {
                    crc = (crc ^ data)&0xff; // i loathe java's promotion rules
                    for (int i=0; i<8; i++) {
                        if ((crc & 0x01) != 0) {
                            crc = ((crc >> 1) ^ 0x8c)&0xff; //change this to unsigned bit shift?
                        } else {
                            crc = (crc >> 1)&0xff; //change this to unsigned bit shift?
                        }
                    }
                }

                /**
                 * Reset the crc.
                 */
                void IButtonCRC::reset() {
                    crc = 0;
                }
    
				 /**
                 * Get the 8-bit crc value.
                 */
                char unsigned IButtonCRC::getCRC() {
                    return (char unsigned)crc;
                }