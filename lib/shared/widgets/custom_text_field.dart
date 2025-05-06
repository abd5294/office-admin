import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscured;
  final bool isNumeric;
  final Function(String) onChange;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChange,
    this.isNumeric = false,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          suffixIcon:
              isObscured
                  ? Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.grey.shade400,
                    size: 16,
                  )
                  : null,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
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
      ),
    );
  }
}
