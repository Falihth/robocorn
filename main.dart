import 'package:flutter/material.dart';
import 'pages/auth_page.dart';
import 'pages/Control.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROBOCORN',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 61, 59, 59),
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/control': (context) => DpadControl(), 
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 59, 59),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 61, 59, 59),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tambahkan gambar di sini
            Image.asset(
              'lib/assets/logo.png', // Path gambar
              height: 300, // Ukuran gambar
            ),
            SizedBox(height: 20), // Jarak antara gambar dan teks
            Text(
              'Welcome to Home Page!',
              style: TextStyle(fontSize: 18, color: Colors.orange),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/control');
              },
              child: Text('Go to Control Page'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
