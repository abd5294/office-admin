import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final int crossAxis;
  final bool isIconRight;

  const CustomCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.backgroundColor = Palette.primaryColor,
    this.crossAxis = 1,
    this.isIconRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/texture.png',
              fit: BoxFit.cover,
              height: 90,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.9, -1.3),
                  radius: 0.8,
                  colors: [
                    backgroundColor.withOpacity(0),
                    backgroundColor.withOpacity(0.3),
                    backgroundColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 6,
                          blurRadius: 15,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.folder,
                      color: Color(0xFFE3B10F),
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: Colors.white.withAlpha(150),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
