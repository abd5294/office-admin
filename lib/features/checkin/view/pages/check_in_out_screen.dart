import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/large_button.dart';

class CheckInOutScreen extends StatelessWidget {
  static const route = '/check-in-out-employee';

  const CheckInOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondary,
      appBar: AppBar(
        backgroundColor: Palette.secondary,
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 24,
          color: Palette.primaryColor,
        ),
        title: Text(
          'Check In',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.image_rounded, size: 300, color: Color(0xFFb4dbff)),
                Spacer(),
                LargeButton(
                  text: 'Click to Check in',
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
