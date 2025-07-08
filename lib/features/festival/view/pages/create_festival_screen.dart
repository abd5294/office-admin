import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/festival/controller/festival_leave_contorller.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateFestivalScreen extends ConsumerStatefulWidget {
  static final route = '/create-festival';

  const CreateFestivalScreen({super.key});

  @override
  ConsumerState<CreateFestivalScreen> createState() =>
      _CreateFestivalScreenState();
}

class _CreateFestivalScreenState extends ConsumerState<CreateFestivalScreen> {
  final festivalController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();

  @override
  void dispose() {
    festivalController.dispose();
    dateController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final festivalState = ref.watch(festivalLeaveControllerProvider);
    final controller = ref.read(festivalLeaveControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Palette.primaryColor,
          ),
        ),
        title: const Text(
          'Create Festival Leave',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body:
          festivalState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : festivalState.hasError
              ? Center(
                child: Text(
                  'Error: ${festivalState.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Festival Name', style: _labelStyle),
                    const SizedBox(height: 4),
                    CustomTextField(
                      controller: festivalController,
                      hintText: 'Enter Festival\'s name',
                      onChange: (_) {},
                    ),

                    Text('Leave Type', style: _labelStyle),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value:
                          typeController.text.isNotEmpty
                              ? typeController.text
                              : null,
                      decoration: InputDecoration(
                        hintText: "Select Leave Type",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'full-day',
                          child: Text('Full Day'),
                        ),
                        DropdownMenuItem(
                          value: 'half-day',
                          child: Text('Half Day'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          typeController.text = value;
                        }
                      },
                    ),

                    const SizedBox(height: 8),
                    Text('Date', style: _labelStyle),
                    const SizedBox(height: 4),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Festival',
                        hintText: 'Select The Date of Festival',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
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
                              ).toString();

                          dateController.text = formattedDate;
                        }
                      },
                    ),
                    const Spacer(),
                    LargeButton(
                      text: 'Create Holiday',
                      onPressed: () async {
                        final name = festivalController.text.trim();
                        final date = dateController.text.trim();
                        final type = typeController.text.trim();

                        if (name.isEmpty || date.isEmpty || type.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (type != 'full-day' && type != 'half-day') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enter in proper format'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (name.length < 5) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Reason must be above 5 characters',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }

                        final model = FestivalLeaveModel(
                          occasion: name,
                          date: date,
                          type: type,
                        );

                        controller.createFestivalLeave(model);
                        context.pop();
                      },
                    ),
                  ],
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
