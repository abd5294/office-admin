import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor:
            text.contains('Successful')
                ? Colors.green
                : text.contains('Failed')
                ? Colors.red
                : Colors.black,
      ),
    );
}
