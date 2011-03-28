/*
* Day 26 RGB calibrated fading code with serial controls
*/
char str[11]; 

int redPin = 9;    // LED connected to digital pin 9
int greenPin = 11;
int bluePin = 10;
int pins[] = 
{
    redPin, greenPin, bluePin
};

int photoPin = 0;
int photoVal = -1;
int rr, gg, bb = -1;
int minmax, rmax, gmax, bmax = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("Start");
  
  pinMode(redPin, OUTPUT);     
  pinMode(greenPin, OUTPUT);     
  pinMode(bluePin, OUTPUT);  
  digitalWrite(redPin, HIGH);
  digitalWrite(greenPin, HIGH);
  digitalWrite(bluePin, HIGH); 

  digitalWrite(redPin, LOW);
  delay(500);
  rmax = analogRead(photoPin);
  digitalWrite(redPin, HIGH);

  digitalWrite(greenPin, LOW);
  delay(500);
  gmax = analogRead(photoPin);
  digitalWrite(greenPin, HIGH);

  digitalWrite(bluePin, LOW);
  delay(500);
  bmax = analogRead(photoPin);
  digitalWrite(bluePin, HIGH);
  
   sendMax();
   minmax = min(rmax, min(gmax, bmax));
   setRGB(255, 255, 255);
}

void setRGB(int red, int green, int blue) 
{
  red = map(red, 0, minmax, 255, 0);
  green = map(green, 0, minmax,  255, 0);
  blue = map(blue, 0, minmax,  255, 0);
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);
}

void sendRGB(int red, int green, int blue) 
{
      Serial.print(" { \"red\" : ");
      Serial.print(red);
      Serial.print(", \"green\" : ");
      Serial.print(green);
      Serial.print(", \"blue\" : ");
      Serial.print(blue);
      Serial.println("}");
}

void sendMax()
{

    Serial.print(" { \"rmax\" : ");
    Serial.print(rmax);
    Serial.print(", \"gmax\" : ");
    Serial.print(gmax);
    Serial.print(", \"bmax\" : ");
    Serial.print(bmax);
    Serial.println("}");
}



void loop() 
{
int ii = 0;
int nn = 0;
char num[2];
int rgb = 0;
boolean keepgoing = true;

while (keepgoing) 
{
  while (Serial.available() ) 
    {
     {
      str[ii] = Serial.read();
      num[nn] = str[ii];
      //Echo the character as you type
      //Serial.write(str[ii]);

      if (str[ii] == 44)
      {
          if (rgb == 0) 
         {
           rr = atoi(num);
           nn = -1;
           rgb++;
         } 
         else if (rgb == 1)
         {
          gg = atoi(num);
          nn = -1;
          rgb++;
         }
      }
      if (str[ii] == 0x0d )
      {
      keepgoing = false;
       if (rgb == 2)
         {
          bb = atoi(num); 
          nn = -1;
          rgb = 0;
         }      
        sendRGB(rr,gg, bb);
        setRGB(rr, gg, bb);
      }
      ii++;
      nn++;
      }
    } 
} 
  str[ii] = 0;
  Serial.println();
  Serial.println(str);
  setRGB(rr, gg, bb);

}




