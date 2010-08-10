#include "Ethernet.h"
#include "WString.h"
#include "WebServer.h"


//Change this!
static uint8_t mac[6] = { 0x02, 0xAA, 0xBB, 0xCC, 0x00, 0x22 };

//Change this!
static uint8_t ip[4] = { 192, 168, 0, 51 };

//This is only for the buffered version!
int buffer_Size = 1024;
String buffer[1024];
int head = 0;
int tail = 1;
bool buffer_Full = false;
bool buffer_Empty = true;


#define PREFIX "/"
WebServer webserver(PREFIX, 80);

#define COMMAND_TOKEN "command"

//There will be more here... 


void gcodeCmd(WebServer &server, WebServer::ConnectionType type, char *, bool)
{
  if (type == WebServer::POST)
  {
    bool repeat;
    char name[16], value[64];
    do
    {
      repeat = server.readPOSTparam(name, 16, value, 64);
      
      if ( ( strcmp(name, "COMMAND_TOKEN") == 0 ) && ( !memoryFull() ) )
      {
        
        store( String(value) );

      }
      if ( memoryFull() ){
        String outputString = recallNext();
        Serial.flush();
        Serial.println(outputString);
        
        //Wait for the data to be recieved
        while ( true ){
          String temp = Serial.read();
          if ( strcmp(temp, "ok\r\n") ){
            break;
          }
        }
      }
    } while (repeat);
    
    //After the entire thing is read, we can just run through until all the code is processed
    String outputString;
    while ( !memoryEmpty() ){
      outputString = recallNext();
      Serial.flush();
      Serial.println(outputString);
      
      //Waiting time...
      while ( true ){
        String temp = Serial.read();
        if ( strcmp(temp, "ok\r\n") ){
          break;
        }
      }
    }
    
    server.httpSeeOther(PREFIX);
    return;
  }
  
  
  
  
  /* for a GET or HEAD, send the standard "it's all OK headers" */
  server.httpSuccess();

  /* we don't output the body for a HEAD request */
  if (type == WebServer::GET)
  {
    /* store the HTML in program memory using the P macro */
    P(message) = 
"<!DOCTYPE html><html><head>"
  "<title>Webduino AJAX Buzzer Example</title>"
  "<link href='http://jqueryui.com/latest/themes/base/ui.all.css' rel=stylesheet />"
  //"<meta http-equiv='Content-Script-Type' content='text/javascript'>"
  "<script src='http://jqueryui.com/latest/jquery-1.3.2.js'></script>"
  "<script src='http://jqueryui.com/latest/ui/ui.core.js'></script>"
  "<script src='http://jqueryui.com/latest/ui/ui.slider.js'></script>"
  "<style> #slider { margin: 10px; } </style>"
  "<script>"
    "function changeBuzz(event, ui) { $('#indicator').text(ui.value); $.post('/buzz', { buzz: ui.value } ); }"
    "$(document).ready(function(){ $('#slider').slider({min: 0, max:8000, change:changeBuzz}); });"
  "</script>"
"</head>"
"<body style='font-size:62.5%;'>"
  "<h1>Test the Buzzer!</h1>"
  "<div id=slider></div>"
  "<p id=indicator>0</p>"
"</body>"
"</html>";

    server.printP(message);
  }
  
  
  
  
}

void setup()
{
  Ethernet.begin(mac, ip);
  
  webserver.setDefaultCommand(&gcodeCmd);
  
  webserver.begin();
  
  Serial.begin(9600);
}

void loop()
{
  
  webserver.processConnection();
  
  while( ! memoryEmpty() ){
    
    Serial.println( recallNext() );
    
  }
  
}

boolean memoryFull(){
  
  
  return buffer_Full;
}

boolean memoryEmpty(){
  
  return buffer_Empty;  
}

void store(String newCmd){
  
  buffer[tail] = newCmd;
  tail = (tail + 1) % buffer_Size;
  if ( tail == head ){
    buffer_Full = true;
  }
  else{
    buffer_Full = false;
  }
  
}

String recallNext(){
  
  //Buffers are currently being used.  SD cards will be implemented in the future.
  
  String returnedString;
  
  buffer[head] = returnedString;
  head = ( head + 1) % buffer_Size;
  if ( head == tail ){
    buffer_Empty == true;
  }
  else{
    buffer_Empty == false;
  }
 
  return returnedString;
}
