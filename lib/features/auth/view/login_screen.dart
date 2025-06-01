import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/features/auth/controller/auth_controller.dart';
import 'package:office/features/auth/controller/auth_state.dart';
import 'package:office/features/update_password/view/forget_password.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static final route = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.watch(authControllerProvider.notifier);

    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      if (next is AuthSuccess) {
        context.push(HomeScreen.route);
      } else if (next is AuthFailure) {
        showSnackBar(context, next.message);
      }
    });

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
                'Hello There!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                onChange: (value) {},
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                isObscured: true,
                onChange: (value) {},
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  context.push(ForgotPasswordScreen.route);
                },
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              LargeButton(
                text: 'Login',
                onPressed: () {
                  if (authState is AuthLoading) {
                    return;
                  }
                  // if (emailController.text.isEmpty ||
                  //     passwordController.text.isEmpty) {
                  //   showSnackBar(context, 'Please enter all the fields');
                  //   return;
                  // }

                  authController.userLogin(
                    emailController.text,
                    passwordController.text,
                  );
                },
              ),

              Visibility(
                visible: authState is AuthLoading,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
