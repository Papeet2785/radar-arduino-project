#include <Servo.h>
#include "SR04.h"
Servo myservo;
#define TRIG_PIN 13
#define ECHO_PIN 12
SR04 sr04 = SR04(ECHO_PIN, TRIG_PIN);
int distanceLimit = 20;
long distance;
int buzzer = 10;
int sound_duration = 50;
const int servoPin = 11;

int printDistance(int i, int distance) {
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
}

void setup() {
  // put your setup code here, to run once:
  myservo.attach(servoPin);
  myservo.write(0);// move servos to center position -> 90°
  Serial.begin(9600);
  pinMode(buzzer, OUTPUT);
}

void loop() {
 for(int i = 0; i <= 180; i++) {
   myservo.write(i);
   distance=sr04.Distance();
   printDistance(i, distance);
   if(distance <= distanceLimit) {
    digitalWrite(buzzer, HIGH);
    delay(1);
    digitalWrite(buzzer, LOW);
   }
   delay(20);
 }
 for(int i = 180; i >= 0; i--) {
   myservo.write(i);
   distance=sr04.Distance();
   printDistance(i, distance);
   if(distance <= distanceLimit) {
    digitalWrite(buzzer, HIGH);
    delay(1);
    digitalWrite(buzzer, LOW);
   }
   delay(20);
 }
}