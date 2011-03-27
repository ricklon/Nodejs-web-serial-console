/*
* Echo Serial on the Arduino
* with advice from Mark Sproul
*/
char str[10]; 


void setup() {
  Serial.begin(9600);
  Serial.println("Start");
}

void loop() 
{
int ii = 0;
boolean keepgoing = true;
while (keepgoing) 
{
  while (Serial.available() ) 
    {
     {
      str[ii] = Serial.read();
      //Echo the character as you type
      //Serial.write(str[ii]);
      if (str[ii] == 0x0d )
      {
        keepgoing = false;
      }
      ii++;
      }
    }
} 
  str[ii] = 0;
  Serial.println();
  Serial.println(str);
  delay(200);
}
