import 'package:flutter/material.dart'; //
import 'pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          SplashScreen(), // Mengarahkan ke SplashScreen saat aplikasi pertama kali dijalankan
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunda pindah ke halaman berikutnya (LoginPage) selama 3 detik
    Future.delayed(Duration(seconds: 7), () {
      // Setelah 3 detik, pindah ke halaman LoginPage atau halaman lain
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RegistrationPage()), // Ganti dengan halaman yang diinginkan
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF3F3F3F), // Latar belakang Splash Screen (bisa sesuaikan)
      body: Center(
        child: Image.asset(
          'assets/Robocorn.png', // Ganti dengan path logo Anda
          width: 300, // Sesuaikan ukuran logo
        ),
      ),
    );
  }
}
