// Testing the ESP32
#include <WiFi.h>      // For connecting to Wi-Fi on the ESP32
#include <PubSubClient.h>   
#include <TimeLib.h>

/*
#define MRead 34 //Pin that is an A2DConverter.
#define sel3 26
#define sel2 33
#define sel1 25
#define sel0 32
*/
#define MRead 34 //Pin that is an A2DConverter.
#define sel3 35
#define sel2 32
#define sel1 33
#define sel0 25


// Constants and variables.
//Overall loop delay.
int delayTime = 1000;

// Constants and variables for Moisture reading and for delay.
float MReading;
float MReading1;
float MReading2;
float MReading3;
float readingSum; // Holds the sum of before the average.
float MReadingInter; // Holds the reding from the moisture sensor individually.


unsigned long MnDelay = 5000; // Units = miliseconds. Delay of 10 sec between readings when moisture is really low.
unsigned long MxDelay = 6000;// Units = miliseconds. Delay of 20 sec between readings when moisture is really high.
time_t currTime = 0;
time_t prevTime1 = 0;
time_t prevTime2 = 0;
time_t prevTime3 = 0;
unsigned long delay1 = MnDelay / 1000; //Units = seconds.
unsigned long delay2 = MnDelay / 1000;
unsigned long delay3 = MnDelay / 1000;


// Variables and constants for averaging the readings from sensors.
int avgTimes = 3; // The number of smaples of which we are going to the take the average of.
int counter;


// Moisture sensor Calibration COnstants.
// Extreme measurements with paper towels.
float DMeasure = 3385.14; // Measurement from Moisture sensor for dry measurement.
float WMeasure = 1604; // Very Wet paper towel.


// Extreme measurements with greenhouse soil.
float DSoilMeasure = 3136.00; // Measurement from Moisutre sensor dry soil.
float GoldenMeasure = 2381.00; // Measurement of the optimal soil moisture for tomato.
float WSoilMeasure = 1637.00; // Measurement from Moisture sensor for very wet soil.



//Wifi constants and variables.
const char* ssid = "wustl-2.0";
const char* password = "";


//const char* ssid = "DYNet";       // Your Wi-Fi network name (SSID)
//const char* password = "12345689"; // Your Wi-Fi password


//MQTT Stuff
// Replace your MQTT Broker IP address here://Change this to the ip address of the pi. IP address changes when the pi is connected to a different network.
const char* mqtt_server = "172.27.39.78";

//Creating the ESP32 MQTT Client
WiFiClient espClient;
PubSubClient client(espClient);



// put function declarations here:
float channelSel(int, float, float); // Reads from a specified sensor.
unsigned long delayCalc(float, float, float, unsigned long, unsigned long); //Dynamic delay calculation. Adjusts the delay based on the sensor reading.
void pubSens(float, int); // Publishes data from a sensor, appending the sensor number to the front of the reading so that the pi knows which sensors' data is being received.



//Functions for setup. Got function from https://github.com/jiteshsaini/mqtt-demo/blob/main/esp32_clients/esp_mqtt_client1/esp_mqtt_client1.ino
void setup_wifi() {
  delay(50);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  //WiFi.begin(ssid);
  WiFi.begin(ssid, NULL);
  //WiFi.begin(ssid, password); 

  int c=0;
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000); //
    Serial.print(".");
    c=c+1;
    if(c>10){
        ESP.restart(); //restart ESP after 10 seconds
    }
  }

  Serial.println("");
  Serial.print("WiFi connectedto ");
  Serial.println(ssid);
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  
}

// Function to connect to the MQTT server. Got function from https://github.com/jiteshsaini/mqtt-demo/blob/main/esp32_clients/esp_mqtt_client1/esp_mqtt_client1.ino
void connect_mqttServer() {
  // Loop until we're reconnected
  while (!client.connected()) {

        //first check if connected to wifi
        if(WiFi.status() != WL_CONNECTED){
          //if not connected, then first connect to wifi
          setup_wifi();
        }

        //now attemt to connect to MQTT server
        Serial.print("Attempting MQTT connection...");
        // Attempt to connect
        if (client.connect("ESP32_client1")) { // Change the name of client here if multiple ESP32 are connected
          //attempt successful
          Serial.println("connected");
          
          // Subscribe to topics here
          client.subscribe("rpi/broadcast");
          //"client.subscribe("rpi/xyz");" //subscribe more topics here. This is an example.
          
        } 
        else {
          //attempt not successful
          Serial.print("failed, rc=");
          Serial.print(client.state());
          Serial.println(" trying again in 2 seconds");
    
          //blink_led(3,200); //blink LED three times (200ms on duration) to show that MQTT server connection attempt failed
          // Wait 2 seconds before retrying
          delay(2000);
        }
  }
  
}


//this function will be executed whenever there is data available on subscribed topics. Function from https://github.com/jiteshsaini/mqtt-demo/blob/main/esp32_clients/esp_mqtt_client1/esp_mqtt_client1.ino
void callback(char* topic, byte* message, unsigned int length) {
  Serial.print("Message arrived on topic: ");
  Serial.print(topic);
  Serial.print(". Message: ");
  String messageTemp;
  int PiFlag; // 1 if to put the ESP32 to sleep. Can make have other numbers to mean different commands from the Pi.
  float sleepTime; // Specifies the time to go into deep sleep
  String sleepTimeString;
  int micToSecConver = 1000000;
  
  for (int i = 0; i < length; i++) {
    Serial.print((char)message[i]);
    messageTemp += (char)message[i];
    if (i == 0){
      PiFlag = (int)message[i] - '0'; // Has to be either 1 or 0
      Serial.print("Sleep Flag: ");
      Serial.println(PiFlag);
    }
    else {
      sleepTimeString += (char)message[i];
      }
    }
  sleepTime = sleepTimeString.toFloat();; // Should be in seconds.
    
  if (PiFlag == 1) {// Put the ESP32
    esp_sleep_enable_timer_wakeup(micToSecConver * sleepTime);
    Serial.print("Going to sleep for ");
    Serial.print(sleepTime);
    Serial.println("Seconds");

    delay(1000);
    //esp_deep_sleep_start();
  }
    
  
  Serial.println();

  // Check if a message is received on the topic "rpi/broadcast"
  if (String(topic) == "rpi/broadcast") {
      if (messageTemp == "10"){
        Serial.println("Action: blink LED");
        //blink_led(1,1250); //blink LED once (for 1250ms ON time)
      }
  }

  //Similarly add more if statements to check for other subscribed topics 

}





//For debugging.
bool debug = false;
int sel = 0; // The select signal



void setup() {

  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(MRead, INPUT);
  pinMode(sel0, OUTPUT);
  pinMode(sel1, OUTPUT);
  pinMode(sel2, OUTPUT);
  pinMode(sel3, OUTPUT);
  

  //Wifi setup.
  setup_wifi();

  
  // Time Configuration.
  configTime(0, 0, "pool.ntp.org");
  struct tm timeinfo;                 // struct tm holds date/time components
  while (!getLocalTime(&timeinfo)) {  // getLocalTime returns false if it can't get the time yet
    Serial.println("Failed to obtain time");
    delay(1000);
  }

  prevTime1 = time(NULL); // Units = seconds. Initializing currTime to the current epoch time (number of seconds since Jan 1, 1970).
  prevTime2 = time(NULL);
  prevTime3 = time(NULL);
  

  client.setServer(mqtt_server,1883);//1883 is the default port for MQTT server
  client.setCallback(callback);

}

  

void loop() {
  // put your main code here, to run repeatedly:
  if(debug){
    MReading1 = channelSel(sel%3, DMeasure, WMeasure);
    

    if (!client.connected()) {
      connect_mqttServer();
    }
    // Keeps MQTT connection alive and processes incoming messages
    client.loop();

    
    
    

    
    counter = 1;
    readingSum = 0;

    while(counter <= avgTimes){
      MReadingInter = channelSel(sel%3, DMeasure, WMeasure);
      readingSum = readingSum + MReadingInter;
      counter = counter + 1; // increment the counter.
      delay(500);
    }
    
    MReading1 = readingSum / counter;
    Serial.print("The averaged moisture sensor for channel ");
    Serial.print(sel%3);
    Serial.print(": ");
    Serial.print(MReading1);
    Serial.println("%");
    
    

    sel = sel + 1;
    
    delay(2000);
    
  } else{ // Start of the actual code.
    
    //Connect to MQTT server.
    if (!client.connected()) {
      connect_mqttServer();
    }
    
    
    //Updating current time.
    currTime = time(NULL);


    if (!client.connected()) {
      connect_mqttServer();
    }
    
    // Keeps MQTT connection alive and processes incoming messages
    client.loop();
    
    if( (currTime - prevTime1)  >= delay1){
      prevTime1 = currTime;
      counter = 1;
      readingSum = 0;

      while(counter <= avgTimes){
        MReadingInter = channelSel(0, DMeasure, WMeasure);
        readingSum = readingSum + MReadingInter;
        counter = counter + 1; // increment the counter.
        delay(500);
      }
      
      MReading1 = readingSum / (counter - 1);
      Serial.print("The averaged moisture sensor for channel 0: ");
      Serial.print(MReading1);
      Serial.println("%");
      delay1 = delayCalc(MReading1, DMeasure, WMeasure, MnDelay, MxDelay);

      pubSens(MReading1, 0); //Publish reading from the moisture sensor with appended 1 in the front to tell the PI that the reading is from the 1st sensor.
      
    } 



    if( (currTime - prevTime2)  >= delay2){
      prevTime2 = currTime;
      counter = 1;
      readingSum = 0;

      while(counter <= avgTimes){
        MReadingInter = channelSel(1, DMeasure, WMeasure);
        readingSum = readingSum + MReadingInter;
        counter = counter + 1;
        delay(500);
      }
      
      MReading2 = readingSum / (counter - 1);
      Serial.print("The averaged moisture sensor for channel 1: ");
      Serial.print(MReading2);
      Serial.println("%");
      delay2 = delayCalc(MReading2, DMeasure, WMeasure, MnDelay, MxDelay);

      pubSens(MReading2, 1);
    }

    

    if( (currTime - prevTime3)  >= delay3){
      prevTime3 = currTime;
      counter = 1;
      readingSum = 0;

      while(counter <= avgTimes){
        MReadingInter = channelSel(2, DMeasure, WMeasure);
        readingSum = readingSum + MReadingInter;
        counter = counter + 1;
        delay(500);
      }
      
      MReading3 = readingSum / (counter - 1);
      Serial.print("The averaged moisture sensor for channel 2: ");
      Serial.print(MReading3);
      Serial.println("%");
      delay3 = delayCalc(MReading3, DMeasure, WMeasure, MnDelay, MxDelay);

      pubSens(MReading3, 2);
    }

    delay(delayTime);
  }
}




// put function definitions here:
float channelSel(int selSig, float dryMeasure, float wetMeasure) { //Reads the moisture reading from a specified sensor, then report it back as a percentage of the max moisture the sensor can read.
  //Constants and variables:
  float moistReading;
  float moistPercent;
  
  switch(selSig){
    case 0://channel 0 is viewed
        digitalWrite(sel0, LOW);
        digitalWrite(sel1, LOW);
        digitalWrite(sel2, LOW);
        digitalWrite(sel3, LOW);
        break;
        
      case 1: // channel 1 is viewed.
        digitalWrite(sel0, HIGH);
        digitalWrite(sel1, LOW);
        digitalWrite(sel2, LOW);
        digitalWrite(sel3, LOW);
        break;
      
        
      case 2: // channel 2 is viewed.
        digitalWrite(sel0, LOW);
        digitalWrite(sel1, HIGH);
        digitalWrite(sel2, LOW);
        digitalWrite(sel3, LOW);
        break;
  }
  moistReading = analogRead(MRead);
  moistPercent = ((dryMeasure - moistReading) / (dryMeasure - wetMeasure)) * 100; // Expresses the moisture readng as a percentage of its max and min raw readings.
  if(1){
    Serial.print("Raw Moisture Reading ");
    Serial.print(selSig);
    Serial.print(": ");
    Serial.println(moistReading);
     
  }
  Serial.print("Moisture Reading channel ");
  Serial.print(selSig);
  Serial.print(": ");
  //Serial.println(moistReading);
  Serial.print(moistPercent);
  Serial.println("%");
  Serial.println();
  return moistPercent;
}



unsigned long delayCalc(float moisture, float dryMeasure, float wetMeasure, unsigned long minDelay, unsigned long maxDelay) { // Function to calculate the delay of reading a sensor based on its moisture reading.
  unsigned long delayT;
  delayT = (minDelay + ( ( (dryMeasure - moisture) / (dryMeasure - wetMeasure) ) * (maxDelay - minDelay) )) / 1000; // Units = seconds. When moisture is high, wait longer before reading sensor. Opposite when moisture level is low.
  return delayT;
}


void pubSens(float MReading, int chan){
  String pubSens = String(MReading);
  pubSens = String(chan) + " " + pubSens; // Concatenates sensor number to the front of the percent reading to tell the Pi that the data is from sensor #.
  client.publish("esp32/sensor1", pubSens.c_str()); //topic name (to which this ESP32 publishes its data). Sends over .
  if(1){
    Serial.print("Published Data: ");
    Serial.println(pubSens);
    Serial.println();
  }
}
