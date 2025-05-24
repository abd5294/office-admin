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
  final String designation;
  final String address;
  final String gender;
  final String dob;
  final String emergencyContacts;

  const EditEmployeeScreen({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.designation,
    required this.address,
    required this.gender,
    required this.dob,
    required this.emergencyContacts,
  });

  @override
  ConsumerState<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends ConsumerState<EditEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final passController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final emergencyContactsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    bloodGroupController.text = '';

    passController.text = '';
    designationController.text = widget.designation;
    addressController.text = widget.address;
    genderController.text = widget.gender;
    dobController.text = widget.dob;
    emergencyContactsController.text = widget.emergencyContacts;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bloodGroupController.dispose();
    passController.dispose();
    designationController.dispose();
    addressController.dispose();
    genderController.dispose();
    dobController.dispose();
    emergencyContactsController.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
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
              const SizedBox(height: 4),
              CustomTextField(
                controller: nameController,
                hintText: 'Enter employee\'s name',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter employee\'s Email',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: passController,
                hintText: 'Enter employee\'s password to change',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Designation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: designationController,
                hintText: 'Enter employee\'s designation',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: addressController,
                hintText: 'Enter employee\'s address',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: genderController,
                hintText: 'Enter Gender (Male / Female)',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'DOB',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: dobController,
                hintText: 'Enter DOB (YYYY-MM-DD)',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Phone',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: phoneController,
                hintText: 'Enter employee\'s Phone Number',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Blood Group',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: bloodGroupController,
                hintText: 'Enter employee\'s Blood group',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),
              LargeButton(
                text: 'Edit Employee',
                onPressed: () {
                  final password = passController.text;
                  if (password == '' && password.length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password must be at least 8 characters long',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final bloodGroup =
                      bloodGroupController.text.trim().toUpperCase();
                  final validBloodGroups = [
                    'A+',
                    'A-',
                    'B+',
                    'B-',
                    'AB+',
                    'AB-',
                    'O+',
                    'O-',
                  ];

                  if (!validBloodGroups.contains(bloodGroup)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter a valid blood group (e.g., A+, O-, AB+).',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final updatedEmployee = UpdateEmployeeModel(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    bloodGroup: bloodGroupController.text.trim(),
                    password: passController.text.trim(),
                    gender: genderController.text.trim(),
                    designation: designationController.text.trim(),
                    address: addressController.text.trim(),
                    dob: dobController.text.trim(),
                  );
                  empState.updateEmployee(updatedEmployee, widget.id);
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
