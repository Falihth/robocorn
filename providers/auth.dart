import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> signup(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBVAWfkPGd8c9oRpf6tDnUgnzTwI9rrTyo");

    final response = await http.post(
      url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw Exception(responseData['error']['message']); 
    }
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBVAWfkPGd8c9oRpf6tDnUgnzTwI9rrTyo");

    final response = await http.post(
      url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw Exception(responseData['error']['message']);
    }
  }
}
