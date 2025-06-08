import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';

class CheckinErrorScreen extends StatelessWidget {
  final String errorString;
  static const route = '/checkInError';
  const CheckinErrorScreen({super.key, required this.errorString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorString,
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Palette.primaryColor),
                ),
                onPressed: () => context.pop(),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
