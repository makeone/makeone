#include "Ethernet.h"
#include "WebServer.h"

static uint8_t mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };

static uint8_t ip[] = { 192, 168, 0, 51 };

#define WEBDUINO_SERIAL_DEBUGGING 1


#define PREFIX "/"
WebServer webserver(PREFIX, 80);

void gcodeCmd(WebServer &server, WebServer::ConnectionType type, char *url_tail, bool tailcomplete){
  server.httpSuccess();
  
//  byte startBuffer[9] = {0xD5, 0x05, byte(14), byte('t'), byte('.'),  byte('b'), byte('f'), byte('b'), 0x01};
  
//  Serial.write(startBuffer, 9);
  
 //   byte buffer1[9] = {0xD5, 0x03, byte(14), byte('G'), byte(9),  byte(0), 0x01};
  //  byte buffer2[9] = {0xD5, 0x03, byte(14), byte('G'), byte(2),  byte(1), 0x01};
   // byte buffer3[34] = {0xD5, byte(30), byte(14), byte('G'), byte('1'), byte(' '), byte('X'), byte('-'), byte('1'), byte('9'), byte('.'), byte('3'), byte('3'), byte(' '), byte('Y'), byte('-'), byte('1'), byte('9'), byte('.'), byte('1'), byte('1'), byte(' '), byte('Z'), byte('0'), byte('.'), byte('7'), byte(' '), byte('F'), byte('2'), byte('4'), byte('0'), byte('.'), byte('0'), 0x01};

 //   Serial.write(buffer1, 9);
  //  while(!Serial.available()){}
   // Serial.write(buffer2, 9);
   // while(!Serial.available()){}
   // Serial.write(buffer3, 34);
  
  
/*  
  byte buffer[36] = {  
    0xD5, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x01
  };
  
  
  int ch;
  
  int count = 0;
  
  for (int i = 3; i < 35; i++){
    ch = server.read();
    if (ch == -1){
      break;
    }
    if (ch == '+'){
      ch = ' ';
    }
    else if (ch == '%'){
      int ch1 = server.read();
      int ch2 = server.read();
      if (ch1 == -1 || ch2 == -1){
        break;
      }  
      char hex[3] = {ch1, ch2, 0};
      ch = strtoul(hex, NULL, 16);
    }
    
    buffer[1+i] = ch;
    count++;
  }
  
  buffer[1] = byte(count);
  
  
  Serial.write(buffer, 36);
  
  */
  
  
  byte stopBuffer[4] = {0xD5, 0x00, byte(15), 0x01};
  
  Serial.write(stopBuffer, 4);
  
  byte printStartBuffer[9] = {0xD5, 0x05, byte(16), byte('t'), byte('.'),  byte('b'), byte('f'), byte('b'), 0x01};
  
  
  
/*  
  while ((ch = server.read()) != -1){
    //Serial.println(count++);
    if (ch == '+'){
      ch = ' ';
    }
    else if (ch == '%'){
      int ch1 = server.read();
      int ch2 = server.read();
      if (ch1 == -1 || ch2 == -1){
        Serial.println();
        Serial.println(ch1);
        Serial.println(ch2);
        Serial.println(count);
        return;
      }
      char hex[3] = {ch1, ch2, 0};
      ch = strtoul(hex, NULL, 16);
    }
    Serial.print((char)ch);

  }
*/  
  //Serial.println();
  //Serial.println(count);
  
  return;
}

void setup(){
  Ethernet.begin(mac, ip);
  
  webserver.setDefaultCommand(&gcodeCmd);
  
  webserver.begin();
  
  Serial.begin(38400);
}

void loop(){
  
  int buffer_length = 4096;
  
  char buffer[buffer_length];
  
  webserver.processConnection();
  
}
