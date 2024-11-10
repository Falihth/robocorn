#include <Servo.h>
int posisi=0;
Servo servo1;

void setupServo()
{
  servo1.attach(12);
  servo1.write(0);
  delay(1000);
}
void Lubang()
{
  for (posisi = 0; posisi <= 90; posisi += 1)
  {
    servo1.write(posisi);
    delay(15);
  }
    for (posisi = 90; posisi >= 0; posisi -= 1)
  {
    servo1.write(posisi);
    delay(15);
  }
} 

 