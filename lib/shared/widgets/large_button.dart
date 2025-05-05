import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/home/view/pages/home_screen.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LargeButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.push(HomeScreen.route);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Palette.primaryColor,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
