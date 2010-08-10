#include <IButtonCRC.h>

int inByte = 0;
int id = 2;
int ledPin =  13; 
int packetTimeOut = 0;
byte START_BYTE = (byte) 0xD5; //all packets start with this
int MAX_PACKET_LENGTH = 256;
byte data[256];
byte command = 0; //0 - simple cmd to request version number
byte cmdLength = (byte) 2;
int x = 0;

void setup(){

  IButtonCRC crc;
  Serial.begin(38400);
  pinMode(ledPin, OUTPUT);   
  digitalWrite(ledPin, LOW);
  data[0] = START_BYTE;
  data[1] = cmdLength; //bit length of cmd is always next
  data[2] = command;
  crc.update(command);
  data[3] = crc.getCRC();
}

void loop(){
  
 // for (x=0;x<256;x++) { 
    Serial.println((byte)data); //send actual command
 // }
  delay(20);
  //common to wait 20 milliseconds for response
  if (Serial.available() > 0) {
    digitalWrite(ledPin, HIGH);   // set the LED on
    // get incoming byte:
    inByte = Serial.read();  //read incoming bytes, if any
    delay(1000);
    //Serial.println(inByte);
    digitalWrite(ledPin, LOW);  
   } else {
     packetTimeOut = 1; //if there is no response, assume the packet timed out
   }




}

