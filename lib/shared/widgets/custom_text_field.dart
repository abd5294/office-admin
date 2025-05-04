import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscured;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      onChanged: (value) {},
      decoration: InputDecoration(
        suffixIcon:
            isObscured
                ? Icon(Icons.remove_red_eye_sharp, color: Colors.grey.shade400)
                : null,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      obscureText: isObscured,
    );
  }
}
