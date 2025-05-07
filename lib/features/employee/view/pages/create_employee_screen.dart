import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateEmployeeScreen extends StatefulWidget {
  static final route = '/create-emp';

  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Palette.primaryColor,
          ),
        ),
        title: const Text(
          'Create Employee',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F3036),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter employee\'s name',
              onChange: (value) {},
            ),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F3036),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: emailController,
              hintText: 'Enter employee\'s Email',
              onChange: (value) {},
            ),
            const SizedBox(height: 20),

            const Text(
              'Phone',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F3036),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: phoneController,
              hintText: 'Enter employee\'s Phone Number',
              onChange: (value) {},
            ),
            const SizedBox(height: 20),

            const Text(
              'Blood Group',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F3036),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: bloodGroupController,
              hintText: 'Enter employee\'s Blood group',
              onChange: (value) {},
            ),
            const SizedBox(height: 20),

            const Text(
              'Role',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F3036),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: roleController,
              hintText: 'Enter employee\'s role',
              onChange: (value) {},
            ),
            const Spacer(),
            LargeButton(
              text: 'Add Employee',
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
