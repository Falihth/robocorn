import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../widgets/textfield.dart';
import 'login_page.dart';

class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Registrasi _registrasiService = Registrasi();

  // Fungsi untuk memproses form dan melakukan registrasi
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Panggil fungsi registrasi dari kelas Registrasi
      final result =
          await _registrasiService.registerWithEmail(email, password);

      if (result == null) {
        setState(() {});

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp4()),
        );
      } else {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F3F3F),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Robocorn.png',
                width: 400,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Hello, farmer !\nlet’s sign up an account',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                      .hasMatch(value)) {
                    return 'Masukkan email yang valid';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                icon: Icons.vpn_key,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Password harus lebih dari 6 karakter';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
                icon: Icons.lock,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
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
                    color: Color(
                        0xFFF19000), // Warna latar belakang untuk Container
                    borderRadius:
                        BorderRadius.circular(30), // Membuat sudut rounded
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF3F3F3F), // Warna teks
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Arahkan ke halaman login saat diklik
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.orange, // Warna orange untuk "Sign in"
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
