import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/features/auth/controller/auth_controller.dart';
import 'package:office/features/auth/view/otp_screen.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static final route = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider.notifier);
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
              const SizedBox(height: 40),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),

              const Text(
                'No worries, Enter your email to receive OTP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  height: 1.8,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                onChange: (value) {},
              ),
              const SizedBox(height: 18),
              LargeButton(
                text: 'Send OTP',
                onPressed: () {
                  if (emailController.text.isEmpty) {
                    showSnackBar(context, 'Please enter email and continue...');
                    return;
                  }
                  authController.sendOtp(emailController.text);
                  context.push(
                    '${OtpScreen.route}?email=${emailController.text}',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
