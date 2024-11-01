void setup() {
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {     
    int command = Serial.parseInt(); 
    if (command > 0){
    Serial.println(command);
    }
  }
}
