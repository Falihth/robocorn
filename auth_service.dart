import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class AuthService {
  // Fungsi untuk login
  Future<String?> loginWithEmail(String email, String password) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseWebApiKey',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final data = json.decode(response.body);

      // Cek jika ada error dari Firebase
      if (response.statusCode != 200) {
        return data['error']['message'] ?? 'Terjadi kesalahan';
      }

      // Dapatkan idToken dari respons
      final idToken = data['idToken'];
      if (idToken != null) {
        print('Login Berhasil! Token: $idToken');
        return null; // Menandakan login berhasil tanpa error
      } else {
        return 'Gagal mendapatkan token';
      }
    } catch (e) {
      return 'Terjadi kesalahan: $e';
    }
  }
}
