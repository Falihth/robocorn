void setup() {
  Serial.begin(9600); 
}

void loop() {
  if (Serial.available() > 0) {           
    String commandStr = Serial.readStringUntil('\n');  
    int command = commandStr.toInt();                  

    if (command > 0) {                   
      switch (command) {
        case 1:
          Serial.println("Maju");
          Motormaju();
          delay(500);
          break;

        case 2:
          Serial.println("Kanan");
          Motorkanan();
          delay(500);
          break;

        case 3:
          Serial.println("Kiri");
          Motorkiri();
          delay(500);
          break;

        case 4;
          Serial.println("mundur");
          Motormundur();
          delay(500);
          break;  

        default:
          Serial.println("Perintah tidak dikenali");
          Motorstop();
          break;
      }
    }
    
    while (Serial.available() > 0) {
      Serial.read();
    }
  }
}
