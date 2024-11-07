import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../providers/auth.dart' as MyAuth; 

class LoginPage extends StatelessWidget {
  final MyAuth.Auth auth = MyAuth.Auth();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'MyApp',
      onLogin: _authenticateUser,
      onSignup: _registerUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed('/home');
      },
      theme: LoginTheme(
        primaryColor: Colors.blue,
        accentColor: Colors.white,
      ),
    );
  }

  Future<String?> _authenticateUser(LoginData data) async {
    try {
      await auth.login(data.name, data.password); 
      return null;
    } catch (error) {
      return 'Login gagal: ${error.toString()}';
    }
  }

  Future<String?> _registerUser(SignupData data) async {
    final String email = data.name ?? '';
    final String password = data.password ?? '';
    try {
      await auth.signup(email, password); 
      return null;
    } catch (error) {
      return 'Registrasi gagal: ${error.toString()}';
    }
  }

  Future<String?> _recoverPassword(String email) async {
    return 'Fitur pemulihan kata sandi belum diimplementasikan';
  }
}
