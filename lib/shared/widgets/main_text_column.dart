import 'package:flutter/material.dart';

class MainTextColumn extends StatelessWidget {
  final String title;
  final String subTitle;

  const MainTextColumn({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 46),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            height: 1.8,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
