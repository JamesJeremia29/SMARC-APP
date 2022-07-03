#include <WiFi.h>                                                
#include <IOXhop_FirebaseESP32.h> 
#include <analogWrite.h>
#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif   
                                         
#define FIREBASE_Host "smarc-90461-default-rtdb.firebaseio.com"                   // replace with your Firebase Host
#define FIREBASE_authorization_key "Tt8dHsbmfyGOXX844Aeq0B8iMCRk4SEITfEvve89" // replace with your secret key
#define Your_SSID "Yudi1"       // replace with your SSID
#define Your_PASSWORD "Yudi1807"          //replace with your Password

int led; 
int motor;                                                     // LED State
int motor1pin1 = 27;
int motor1pin2 = 26;
int en1 = 12;
int motor2pin1 = 32;
int motor2pin2 = 33;
int en2 = 13;
int led_brake = 2;
int led_front = 4;
                                                              

void setup() {

  Serial.begin(115200);
  delay(1000);
  pinMode(2, OUTPUT);                 
  WiFi.begin(Your_SSID, Your_PASSWORD);                                      
  Serial.print("Connecting to WIFI");
  while (WiFi.status() != WL_CONNECTED) {
  Serial.print(".");
  delay(500);
  }

  Serial.println();
  Serial.print("Connected to WIFI!");
  Serial.println();
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());                                                      //print local IP address
  Firebase.begin(FIREBASE_Host, FIREBASE_authorization_key);                                       // connect to firebase

  pinMode(motor1pin1, OUTPUT);
  pinMode(motor1pin2, OUTPUT);
  pinMode(motor2pin1, OUTPUT);
  pinMode(motor2pin2, OUTPUT);
  
  pinMode(en1, OUTPUT); 
  pinMode(en2, OUTPUT);

  pinMode(led_brake, OUTPUT);
  pinMode(led_front, OUTPUT);

}

void loop() {

  motor = Firebase.getInt("/esp32/motor"); 
  switch (motor) {       
    case 1:                    
      Serial.println("Forward");                 
      analogWrite(en1, 150); //ENA pin
      analogWrite(en2, 150); //ENB pin
      digitalWrite(motor1pin1, HIGH);
      digitalWrite(motor1pin2, LOW);
      digitalWrite(motor2pin1, HIGH);
      digitalWrite(motor2pin2, LOW);
      digitalWrite(led_brake, LOW);
      break;

    case 2:                    
      Serial.println("Backwards");                 
      analogWrite(en1, 125); //ENA pin
      analogWrite(en2, 125); //ENB pin
      digitalWrite(motor1pin1, LOW);
      digitalWrite(motor1pin2, HIGH);
      digitalWrite(motor2pin1, LOW);
      digitalWrite(motor2pin2, HIGH);
      digitalWrite(led_brake, LOW);
      break;

     case 4:                    
       Serial.println("Right");                 
       analogWrite(en1, 150); //ENA pin
       analogWrite(en2, 200); //ENB pin
       digitalWrite(motor1pin1, HIGH);
       digitalWrite(motor1pin2, LOW);
       digitalWrite(motor2pin1, HIGH);
       digitalWrite(motor2pin2, LOW);
       delay (2000);
       analogWrite(en1, 150); //ENA pin
       analogWrite(en2, 150); //ENB pin
       digitalWrite(motor1pin1, HIGH);
       digitalWrite(motor1pin2, LOW);
       digitalWrite(motor2pin1, HIGH);
       digitalWrite(motor2pin2, LOW);
       digitalWrite(led_brake, LOW);
       break;

     case 3:                    
       Serial.println("Left");                 
       analogWrite(en1, 200); //ENA pin
       analogWrite(en2, 150); //ENB pin
       digitalWrite(motor1pin1, HIGH);
       digitalWrite(motor1pin2, LOW);
       digitalWrite(motor2pin1, HIGH);
       digitalWrite(motor2pin2, LOW);
       delay (2000);
       analogWrite(en1, 150); //ENA pin
       analogWrite(en2, 150); //ENB pin
       digitalWrite(motor1pin1, HIGH);
       digitalWrite(motor1pin2, LOW);
       digitalWrite(motor2pin1, HIGH);
       digitalWrite(motor2pin2, LOW);
       digitalWrite(led_brake, LOW);
       break;

     case 0:                      
       Serial.println("Brake");                 
       analogWrite(en1, 0); //ENA pin
       analogWrite(en2, 0); //ENB pin
       digitalWrite(motor1pin1, LOW);
       digitalWrite(motor1pin2, LOW);
       digitalWrite(motor2pin1, LOW);
       digitalWrite(motor2pin2, LOW);
       digitalWrite(led_brake, HIGH);
       break;
  }                

  led  = Firebase.getInt("/esp32/led");
  switch (led) {
    case 1:  
      digitalWrite(led_front, HIGH);
      break;
    case 0:
      digitalWrite(led_front, LOW);  
      break;
  }

}
