import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/festival/controller/festival_leave_contorller.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class EditFestivalScreen extends ConsumerStatefulWidget {
  static const route = '/edit-festival';
  final FestivalLeaveModel festival;

  const EditFestivalScreen({super.key, required this.festival});

  @override
  ConsumerState<EditFestivalScreen> createState() => _EditFestivalScreenState();
}

class _EditFestivalScreenState extends ConsumerState<EditFestivalScreen> {
  late final TextEditingController festivalController;
  late final TextEditingController dateController;
  late final TextEditingController typeController;
  final List<String> types = ['full-day', 'half-day'];

  @override
  void initState() {
    super.initState();
    festivalController = TextEditingController(text: widget.festival.occasion);
    dateController = TextEditingController(text: widget.festival.date);
    typeController = TextEditingController(text: widget.festival.type);
  }

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
          'Edit Festival Leave',
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
                    const SizedBox(height: 8),
                    Text('Leave Type', style: _labelStyle),
                    const SizedBox(height: 4),
                    DropdownButton<String>(
                      value: typeController.text,
                      items:
                          types.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            typeController.text = newValue;
                          });
                        }
                      },
                    ),
                    Text('Date', style: _labelStyle),
                    const SizedBox(height: 8),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Date of Festival',
                        hintText: 'Select The Date of Festival',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.tryParse(widget.festival.date) ??
                              DateTime.now(),
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
                    const Spacer(),
                    LargeButton(
                      text: 'Update Holiday',
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
                          return;
                        }

                        final updatedModel = FestivalLeaveModel(
                          occasion: name,
                          date: date,
                          type: type,
                          id: widget.festival.id,
                        );
                        controller.updateFestivalLeave(updatedModel);
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
