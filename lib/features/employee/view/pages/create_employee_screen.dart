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
  final roleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final employeeIDController = TextEditingController();
  final totalLeavesController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final emergencyContactsController = TextEditingController();

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: nameController,
                hintText: 'Enter employee\'s name',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Role', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: roleController,
                hintText: 'Enter employee\'s role',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Email', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter employee\'s Email',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Password', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter employee\'s Password',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Employee ID', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: employeeIDController,
                hintText: 'Enter employee\'s ID',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Total Leaves', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: totalLeavesController,
                hintText: 'Enter employee\'s total leaves',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Designation', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: designationController,
                hintText: 'Enter employee\'s designation',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Address', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: addressController,
                hintText: 'Enter employee\'s address',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Blood Group', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: bloodGroupController,
                hintText: 'Enter employee\'s blood group',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Gender', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: genderController,
                hintText: 'Enter employee\'s gender',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Phone', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: phoneController,
                hintText: 'Enter employee\'s phone number',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('DOB', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: dobController,
                hintText: 'Enter employee\'s DOB',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Emergency Contacts', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: emergencyContactsController,
                hintText: 'Enter contact numbers (comma separated)',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              LargeButton(
                text: 'Add Employee',
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      roleController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      employeeIDController.text.isEmpty ||
                      totalLeavesController.text.isEmpty ||
                      designationController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      bloodGroupController.text.isEmpty ||
                      genderController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      dobController.text.isEmpty ||
                      emergencyContactsController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2F3036),
  );
}
