#include <Servo.h>

int posisi1 = 0;
int posisi2 = 180;
Servo servo1;
Servo servo2;

void setupServo()
{
  servo1.attach(12);
  servo1.write(0);
  delay(1000);
  
  servo2.attach(13);
  servo2.write(0);
  delay(1000);
}

void Lubang()
{
  for (posisi1 = 0; posisi1 <= 90; posisi1 += 1)
  {
    servo1.write(posisi1);
    delay(5);
  }
  for (posisi1 = 90; posisi1 >= 0; posisi1 -= 1)
  {
    servo1.write(posisi1);
    delay(5);
  }
}

void Benih()
{
  
  for (posisi2 = 180; posisi2 >= 0; posisi2 -= 1)
  {
    servo2.write(posisi2);
    delay(3);
  }
  for (posisi2 = 0; posisi2 <= 180; posisi2 += 1)
  {
    servo2.write(posisi2);
    delay(3);
  }
}
