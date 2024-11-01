#define moto1pin1  ;
#define moto1pin2  ;
#define moto2pin1  ;
#define moto2pin2  ;

void setupMotor() {
  pinmode(, OUTPUT);
  pinmode(, OUTPUT);
  pinmode(, OUTPUT);
  pinmode(, OUTPUT);

}

void Motormaju() {
  digitalWrite( ,HIGH);
  digitalWrite( ,LOW);

  digitalWrite( ,HIGH);
  digitalWrite( ,LOW);
}


void Motorkanan(){
  digitalWrite( ,LOW);
  digitalWrite( ,LOW);

  digitalWrite( ,HIGH);
  digitalWrite( ,LOW);
}

void Motorkiri(){
  digitalWrite( ,HIGH);
  digitalWrite( ,LOW);

  digitalWrite( ,LOW);
  digitalWrite( ,LOW);
}

void Motormundur(){
  digitalWrite(, LOW);
  digitalWrite(, HIGH);
  
  digitalWrite(, LOW);
  digitalWrite(, HIGH);
}

void Motorstop(){
  digitalWrite( ,LOW);
  digitalWrite( ,LoW);

  digitalWrite( ,Low);
  digitalWrite( ,Low);
}