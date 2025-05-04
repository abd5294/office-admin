import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_text_field.dart';

class EditEmployeeScreen extends StatefulWidget {
  static final route = '/edit-emp';

  const EditEmployeeScreen({super.key});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 24,
          color: Palette.primaryColor,
        ),
        title: Text(
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
            Text(
              'Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter employee\'s name',
            ),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: emailController,
              hintText: 'Enter employee\'s Email',
            ),
            SizedBox(height: 20),

            Text(
              'Phone',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: phoneController,
              hintText: 'Enter employee\'s Phone Number',
            ),
            SizedBox(height: 20),

            Text(
              'Blood Group',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: bloodGroupController,
              hintText: 'Enter employee\'s Blood group',
            ),
            SizedBox(height: 20),

            Text(
              'Role',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: roleController,
              hintText: 'Enter employee\'s role',
            ),
          ],
        ),
      ),
    );
  }
}
