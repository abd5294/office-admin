import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/controller/manage_employee_controller.dart';
import 'package:office/features/employee/models/updated_employee_model.dart';
import 'package:office/shared/models/employee_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class EditEmployeeScreen extends ConsumerStatefulWidget {
  static final route = '/edit-emp';

  final int id;
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String role;

  const EditEmployeeScreen({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.role,
  });

  @override
  ConsumerState<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends ConsumerState<EditEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final roleController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    bloodGroupController.text = widget.bloodGroup;
    roleController.text = widget.role;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bloodGroupController.dispose();
    roleController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final empState = ref.watch(manageEmployeeControllerProvider.notifier);
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
          'Edit Employee',
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
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F3036),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: emailController,
              hintText: 'Enter employee\'s password to change',
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
              text: 'Edit Employee',
              onPressed: () {
                final updatedEmployee = UpdateEmployeeModel(
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  bloodGroup: bloodGroupController.text,
                  role: roleController.text,
                  password: passController.text
                );
                empState.updateEmployee(updatedEmployee, widget.id);
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
