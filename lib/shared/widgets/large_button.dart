import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LargeButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Palette.primaryColor,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
