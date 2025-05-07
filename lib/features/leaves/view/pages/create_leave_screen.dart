import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateLeaveScreen extends StatefulWidget {
  static final route = '/create-leave';

  const CreateLeaveScreen({super.key});

  @override
  State<CreateLeaveScreen> createState() => _CreateLeaveScreenState();
}

class _CreateLeaveScreenState extends State<CreateLeaveScreen> {
  final nameController = TextEditingController();
  final reasonController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Create Leave Application',
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
              hintText: 'Enter profile\'s name',
              onChange: (value) {},
            ),
            SizedBox(height: 20),
            Text(
              'Reason',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: reasonController,
              hintText: 'Enter the reason',
              onChange: (value) {},
            ),
            SizedBox(height: 20),

            Text(
              'Date Of Leave',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: dateController,
              hintText: 'Enter your Phone Number',
              onChange: (value) {},
            ),
            SizedBox(height: 20),

            Text(
              'Type of leave',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: typeController,
              hintText: 'Enter Type (Half or Full day)',
              onChange: (value) {},
            ),
            Spacer(),
            LargeButton(
              text: 'Send Application',
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
