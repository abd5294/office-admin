import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String buttonText;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Text(buttonText, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
