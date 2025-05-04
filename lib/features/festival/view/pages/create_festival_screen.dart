import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateFestivalScreen extends StatefulWidget {
  static final route = '/create-festival';

  const CreateFestivalScreen({super.key});

  @override
  State<CreateFestivalScreen> createState() => _CreateFestivalScreenState();
}

class _CreateFestivalScreenState extends State<CreateFestivalScreen> {
  final festivalController = TextEditingController();
  final dateController = TextEditingController();
  final noteController = TextEditingController();

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
          'Create Festival Leave',
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
              'Festival Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: festivalController,
              hintText: 'Enter Festival\'s name',
            ),
            SizedBox(height: 20),
            Text(
              'Date',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              controller: dateController,
              hintText: 'Enter Festival\'s Date',
            ),
            SizedBox(height: 20),

            Text(
              'Note',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(controller: noteController, hintText: 'Enter Note'),
            Spacer(),
            LargeButton(
              text: 'Create Holiday',
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
