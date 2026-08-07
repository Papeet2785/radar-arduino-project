import processing.serial.*;

Serial myPort;
String rawData = "";
int angle;
int distance;
boolean showRedLine;
float distanceInPixels;
PFont myFont;

void setup() {
 size(1080,720);
 smooth();
 myPort = new Serial(this, "/dev/ttyACM0", 9600);
 myFont  = createFont("Comfortaa", 30);
}

void draw() {
  fill(0, 4);
  rect(0, 0, width, height - 50);
  drawRadar();
  drawObject();
  drawLine();
  fill(0,0,0);
  rect(0, height - 50, width, 50);
  drawText();
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - 50);
  noFill();
  strokeWeight(1);
  stroke(100, 250, 25);
  int numberOfCircles = 4;
  float radius;
  for(int i = 0; i < numberOfCircles; i++) {
    radius = (width * (i * 0.325));
    arc(0, 0, radius, radius, PI, TWO_PI);
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(10);
  float centerX = width / 2;
  float centerY = height - height * 0.075;
  if(showRedLine) {
    stroke(255, 0, 0);
    line(
        centerX,
        centerY,
        centerX - distanceInPixels * cos(radians(angle)),
        centerY - distanceInPixels * sin(radians(angle))
    );
  }
  else
  {
    stroke(50, 250, 50);
    float lineLength = height * 0.75;
    float x2 = centerX + lineLength * -1 * cos(radians(angle));
    float y2 = centerY - lineLength * sin(radians(angle));
    line(centerX, centerY, x2, y2);
  }

  popMatrix();  
}

void drawObject() {
    pushMatrix();
    translate(width / 2, height - 50);
    strokeWeight(10);
    stroke(255, 0, 0);
    line(0, 0, -1 * distanceInPixels * cos(radians(angle)), -1 * distanceInPixels * sin(radians(angle)));
    popMatrix();
}

void drawText() {
  pushStyle();
  textSize(24);
  fill(255);
  text("Papeet2785 - radar", 10, height - 10);
  if (!showRedLine) {
    text("OUT OF RANGE", width / 4, height - 10);
  }
  else {
    fill(255, 0, 0);
    text("IN RANGE", width / 4, height - 10);
    text("Angle: " + angle + "°", width/2, height - 10);
    text("Distance: " + distance + "cm", width * 3 / 4, height - 10);
  }
  popStyle();
}

void serialEvent(Serial myPort) {
  rawData = myPort.readStringUntil('.');
  if(rawData != null){
    rawData = rawData.substring(0, rawData.length() - 1);
    int commaIndex = rawData.indexOf(',');
    if(commaIndex != -1){
      String angleFromRawData = rawData.substring(0, commaIndex);
      String distanceFromRawData = rawData.substring(commaIndex + 1);
      angle = int(angleFromRawData);
      distance = int(distanceFromRawData);
      if(distance < 20) {
        showRedLine = true;
        distanceInPixels = map(distance, 0, 40, height * 0.025 * 2, height * 0.75 * 2);
      }
      else{
        showRedLine = false;
      }
    }
  }
}
