import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData icon; // Menambahkan parameter icon
  final String? Function(String?)? validator;
  final TextStyle? errorStyle;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.validator,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Icon(icon, color: const Color(0xFF3F3F3F), size: 45),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF3F3F3F),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          errorStyle: errorStyle ??
              TextStyle(
                color:
                    const Color(0xFFF19000), // Warna default jika tidak diset
                fontSize: 14, // Ukuran default
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
