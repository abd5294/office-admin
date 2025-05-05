import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class AuthScreen extends StatefulWidget {
  static final route = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    height: 130,
                    width: 130,
                    child: Image.network(
                      'https://thumbs.dreamstime.com/b/background-office-workplace-computer-table-chair-vector-flat-design-illustration-square-layout-71438088.jpg?w=768',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Welcome!',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                onChange: (value){},
              ),
              SizedBox(height: 12),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                isObscured: true,
                onChange: (value){},
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () {},
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 18),
              LargeButton(
                text: 'Login',
                onPressed: () {
                  context.go(HomeScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
