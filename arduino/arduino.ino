#include <Wire.h>
#include <LiquidCrystal_I2C.h>

const int buzzerPin = 7;
LiquidCrystal_I2C lcd(0x27, 16, 2); // Alamat I2C 0x27, LCD 16x2

void setup() {
  Serial.begin(9600);
  setupMotorPins();
  setupServo();
  pinMode(buzzerPin, OUTPUT);
  
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("ROBOCORN");
}

void loop() {
  if (Serial.available() > 0) {
    String commandStr = Serial.readStringUntil('\n');
    int command = commandStr.toInt();

    if (command > 0) {
      switch (command) {
        case 1:
          beep();
          Serial.println("Maju");
          lcd.setCursor(0, 1);
          lcd.print("Maju     ");
          Motormaju();
          break;

        case 2:
          Serial.println("Kanan");
          lcd.setCursor(0, 1);
          lcd.print("Kanan    ");
          Motorkanan();
          break;

        case 3:
          Serial.println("Kiri");
          lcd.setCursor(0, 1);
          lcd.print("Kiri     ");
          Motorkiri();
          break;

        case 4:
          Serial.println("Stop");
          lcd.setCursor(0, 1);
          lcd.print("Stop     ");
          Motorstop();
          break;

        case 5:
          Serial.println("Melubangi");
          lcd.setCursor(0, 1);
          lcd.print("Melubangi");
          Lubang();
          break;

        case 6:
          beep();
          Serial.println("Bercocok");
          lcd.setCursor(0, 1);
          lcd.print("Bercocok ");
          Benih();
          break;

        default:
          Serial.println("Perintah tidak dikenali");
          lcd.setCursor(0, 1);
          lcd.print("Tidak dikenali");
          Motorstop();
          break;
      }
    }

    while (Serial.available() > 0) {
      Serial.read();
    }
  }
}

void beep(){
  digitalWrite(buzzerPin, HIGH);
  delay(15);
  digitalWrite(buzzerPin, LOW);
  delay(15);
}
