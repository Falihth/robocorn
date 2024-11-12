import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'textfield.dart';
import 'homepage.dart';
import 'package:flutter/services.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String? _errorMessage;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // fungsi jika password tidak diisi
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Email dan password harus diisi';
      });
      return;
    }

    final result = await _authService.loginWithEmail(email, password);

    setState(() {
      _errorMessage = result;
    });

    // Jika tidak ada pesan error, navigasi ke halaman Home
    if (_errorMessage == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CornApp()),
      );
    }
  }

  // design asset login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F3F3F),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/Robocorn.png',
              width: 400,
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome Back, farmer !\nlet’s sign in an account',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              obscureText: false,
              icon: Icons.email,
            ),
            CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                icon: Icons.vpn_key),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.only(
                    left: 0,
                    right:
                        0), // Menghilangkan padding default ElevatedButton // Menghilangkan bayangan (opsional)
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 18, bottom: 18),
                decoration: BoxDecoration(
                  color:
                      Color(0xFFF19000), // Warna latar belakang untuk Container
                  borderRadius:
                      BorderRadius.circular(30), // Membuat sudut rounded
                ),
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xFF3F3F3F), // Warna teks
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
