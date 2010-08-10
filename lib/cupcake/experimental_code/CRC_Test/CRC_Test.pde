void setup() {
  Serial.begin(38400);
}

void loop() {
  byte printStartBuffer[] = {0xD5, 0x05, byte(14), byte('t'), byte('.'),  byte('b'), byte('f'), byte('b'), 0x00, 0x01};
  int crc = 0;
  for (int i = 0; i < 8; i++){
      
    crc = (crc ^ printStartBuffer[i]) & 0xff;
    for (int i = 0; i < 16; i++){
      if ( ( crc & 0x01) != 0){
        crc = (( crc >> 1) ^ 0x8c) & 0xff;
      } else {
        crc = (crc >> 1) & 0xff;
      }
    }
  }
  printStartBuffer[8] = byte(crc);
  
  Serial.println("G90");
  Serial.println("G21");
  Serial.println("G1 X-19.33 Y-19.11 Z0.7 F240.0");
  Serial.println("G1 X-19.33 Y19.19 Z0.7 F240.0");
  Serial.println("G1 X-19.08 Y19.44 Z0.7 F240.0");
  Serial.println("G1 X-14.79 Y19.44 Z0.7 F240.0");
  Serial.println("G1 X-14.53 Y19.19 Z0.7 F240.0");
  Serial.println("G1 X-14.53 Y-18.85 Z0.7 F240.0");
  Serial.println("G1 X-14.28 Y-19.11 Z0.7 F240.0");
  
  byte endBuffer[] = {0xD5, 0x00, byte(15), crc};
  crc = 0;
  for (int i = 0; i < 3; i++){
      
    crc = (crc ^ endBuffer[i]) & 0xff;
    for (int i = 0; i < 16; i++){
      if ( ( crc & 0x01) != 0){
        crc = (( crc >> 1) ^ 0x8c) & 0xff;
      } else {
        crc = (crc >> 1) & 0xff;
      }
    }
  }
  endBuffer[3] = crc;
  
  Serial.write(endBuffer, 4);
  
  byte printGoBuffer[] = {0xD5, 0x05, byte(16), byte('t'), byte('.'),  byte('b'), byte('f'), byte('b'), 0x00, 0x01};
  crc = 0;
  for (int i = 0; i < 9; i++){
      
    crc = (crc ^ printGoBuffer[i]) & 0xff;
    for (int i = 0; i < 16; i++){
      if ( ( crc & 0x01) != 0){
        crc = (( crc >> 1) ^ 0x8c) & 0xff;
      } else {
        crc = (crc >> 1) & 0xff;
      }
    }
  }
  printGoBuffer[9] = byte(crc);
  
  
  Serial.write(printGoBuffer, 20);
  while(true){}
}


