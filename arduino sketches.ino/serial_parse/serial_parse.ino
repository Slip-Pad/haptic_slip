
int onBoardLED = 13;
int touching = 0;
float x = 0.0;
float y = 0.0;
char myCol[20];

void setup(){
   Serial.begin (9600); 
   pinMode(onBoardLED, OUTPUT);
   digitalWrite(onBoardLED, LOW);
}

void loop() {
   int lf = 10;
   touching = Serial.parseInt();
   x = Serial.parseFloat();
   y = Serial.parseFloat();
   if (Serial.read() == '\n'){
     if(touching==0){
       digitalWrite(onBoardLED, LOW);
     } else if(touching==1){
       if (x>0.5 || x<-0.5){
         digitalWrite(onBoardLED, HIGH);
       }
     }
     touching = 0;
   }
}
