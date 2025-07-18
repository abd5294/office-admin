import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/core/utils/validators.dart';
import 'package:office/features/update_password/view/confirm_password_screen.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class OtpScreen extends ConsumerStatefulWidget {
  static final route = '/otp-screen';
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email Sent'), duration: Duration(seconds: 3)),
      ),
    );
  }

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
              const SizedBox(height: 40),
              const Text(
                'Enter the OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Text(
                'Please check your mail and enter the OTP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  height: 1.8,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: otpController,
                hintText: 'Enter OTP',
                onChange: (value) {},
                isNumeric: true,
              ),
              // const SizedBox(height: 12),
              // InkWell(
              //   onTap: () {},
              //   child: Text(
              //     'Resend OTP?',
              //     style: TextStyle(
              //       color: Palette.primaryColor,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 12,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 12),
              LargeButton(
                text: 'Confirm',
                onPressed: () {
                  final otpError = validateOtp(otpController.text);
                  if (otpError != null) {
                    showSnackBar(context, otpError);
                    return;
                  }
                  context.push(
                    '${ConfirmPasswordScreen.route}?otp=${otpController.text}&email=${widget.email}',
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
