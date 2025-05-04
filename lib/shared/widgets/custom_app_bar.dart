import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Palette.secondary,
            ),
            child: Icon(Icons.menu),
          ),
          Spacer(),
          CircleAvatar(
            radius: 24,
            backgroundColor: Palette.secondary,
            child: Icon(Icons.person, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
