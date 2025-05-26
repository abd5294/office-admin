import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/leaves/controller/leave_application_controller.dart';
import 'package:office/features/leaves/model/create_leave_application_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateLeaveScreen extends ConsumerStatefulWidget {
  static final route = '/create-leave';

  const CreateLeaveScreen({super.key});

  @override
  ConsumerState<CreateLeaveScreen> createState() => _CreateLeaveScreenState();
}

class _CreateLeaveScreenState extends ConsumerState<CreateLeaveScreen> {
  final reasonController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(leaveApplicationControllerProvider.notifier);

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
              'Date of leave',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Date of Leave',
                hintText: 'Select The Date of Leave',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  final formattedDate =
                      DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                      ).toUtc().toIso8601String();

                  dateController.text = formattedDate;
                }
              },
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
              text: 'Send Application',
              onPressed: () {
                if (reasonController.text.isEmpty ||
                    dateController.text.isEmpty ||
                    typeController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (reasonController.text.length < 5) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Reason cannot be less than 5 characters',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  return;
                }

                final newApplication = CreateLeaveApplicationModel(
                  reason: reasonController.text,
                  date: dateController.text,
                  type: typeController.text,
                );
                controller.createLeaveApplication(newApplication);
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
