import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class EditLeaveScreen extends StatefulWidget {
  static final route = '/edit-leave';

  const EditLeaveScreen({super.key});

  @override
  State<EditLeaveScreen> createState() => _EditLeaveScreenState();
}

class _EditLeaveScreenState extends State<EditLeaveScreen> {
  final nameController = TextEditingController();
  final reasonController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Palette.primaryColor,
          ),
        ),
        title: Text(
          'Edit Leave Application',
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
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter profile\'s name',
              onChange: (value) {},
            ),
            const SizedBox(height: 8),
            const Text(
              'Reason',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: reasonController,
              hintText: 'Enter the reason',
              onChange: (value) {},
            ),
            const SizedBox(height: 8),

            const Text(
              'Date Of Leave',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: dateController,
              hintText: 'Enter your Phone Number',
              onChange: (value) {},
            ),
            const SizedBox(height: 8),

            const Text(
              'Type of leave',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: typeController,
              hintText: 'Enter Type (Half or Full day)',
              onChange: (value) {},
            ),
            const Spacer(),
            LargeButton(
              text: 'Confirm Edit',
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
