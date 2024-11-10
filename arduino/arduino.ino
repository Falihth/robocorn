
void setup() {
  Serial.begin(9600);
  setupMotorPins();
  setupServo();
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
          break;

        case 2:
          Serial.println("Kanan");
          Motorkanan();
          break;

        case 3:
          Serial.println("Kiri");
          Motorkiri();
          break;

        case 4:
          Serial.println("Stop");
          Motorstop();
          break;

        case 5:
          Serial.println("Bercocok");
          Lubang();
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
