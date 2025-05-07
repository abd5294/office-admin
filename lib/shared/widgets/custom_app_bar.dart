import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Palette.secondary,
            ),
            child: const Icon(Icons.menu, size: 24),
          ),
          const CircleAvatar(
            radius: 24,
            backgroundColor: Palette.secondary,
            child: Icon(Icons.person, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }
}
