import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_text_field.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String buttonText;
  final VoidCallback onPressed;
  final TextEditingController? controller;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.onPressed,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actions: [
        title == 'Cancel Application?'
            ? CustomTextField(
              controller: controller!,
              hintText: 'Enter comment',
              onChange: (p0) {},
            )
            : SizedBox.shrink(),
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
          onPressed: onPressed,
          child: Text(buttonText, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
