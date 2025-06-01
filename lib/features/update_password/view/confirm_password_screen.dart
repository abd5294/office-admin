import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/features/auth/controller/auth_controller.dart';
import 'package:office/features/auth/view/login_screen.dart';
import 'package:office/features/update_password/controller/update_password_controller.dart';
import 'package:office/features/update_password/model/update_password.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class ConfirmPasswordScreen extends ConsumerStatefulWidget {
  static final route = '/confirm-password';
  final int otp;
  final String email;

  const ConfirmPasswordScreen({
    super.key,
    required this.otp,
    required this.email,
  });

  @override
  ConsumerState<ConfirmPasswordScreen> createState() =>
      _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends ConsumerState<ConfirmPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final updatePasswordController = ref.read(
      updatePasswordControllerProvider.notifier,
    );
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
                'Enter Your New Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hintText: 'New password',
                onChange: (value) {},
                isNumeric: true,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Re-Enter New password',
                onChange: (value) {},
                isNumeric: true,
              ),
              const SizedBox(height: 12),
              LargeButton(
                text: 'Confirm',
                onPressed: () {
                  final updatedModel = UpdatePasswordModel(
                    password: passwordController.text,
                    confirmPassword: confirmPasswordController.text,
                    email: widget.email,
                    otp: widget.otp,
                  );
                  updatePasswordController.updatePassword(updatedModel);
                  context.go(LoginScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
