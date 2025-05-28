import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscured;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        keyboardType:
            widget.isNumeric ? TextInputType.number : TextInputType.text,
        controller: widget.controller,
        onChanged: widget.onChange,
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon:
              widget.isObscured
                  ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade400,
                      size: 16,
                    ),
                  )
                  : null,
          hintText: widget.hintText,
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
      ),
    );
  }
}
