import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/auth/view/auth_screen.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  static final route = '/confirm-password';

  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 96,
                    width: 96,
                    child: Image.network(
                      'https://thumbs.dreamstime.com/b/background-office-workplace-computer-table-chair-vector-flat-design-illustration-square-layout-71438088.jpg?w=768',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Enter Your New Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: otpController,
                hintText: 'New password',
                onChange: (value) {},
                isNumeric: true,
              ),
              SizedBox(height: 8),
              CustomTextField(
                controller: otpController,
                hintText: 'Re-Enter New password',
                onChange: (value) {},
                isNumeric: true,
              ),
              SizedBox(height: 12),
              LargeButton(
                text: 'Confirm',
                onPressed: () {
                  context.go(AuthScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
