import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class CustomBottomBar extends StatelessWidget {
  final Widget child;

  const CustomBottomBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 240,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Palette.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
