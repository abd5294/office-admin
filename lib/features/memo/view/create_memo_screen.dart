import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/memo/controller/memo_controller.dart';
import 'package:office/features/memo/controller/department_controller.dart';
import 'package:office/features/memo/model/department_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateMemoScreen extends ConsumerStatefulWidget {
  static final route = '/create-memo';

  const CreateMemoScreen({super.key});

  @override
  ConsumerState<CreateMemoScreen> createState() => _CreateMemoScreenState();
}

class _CreateMemoScreenState extends ConsumerState<CreateMemoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Department? selectedDepartment;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memoState = ref.watch(adminMemoControllerProvider);
    final controller = ref.read(adminMemoControllerProvider.notifier);

    final departmentState = ref.watch(departmentControllerProvider);
    var departmentList = departmentState.value ?? <Department>[];

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
          'Create Memo',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body:
          memoState.isLoading || departmentState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : memoState.hasError
              ? Center(
                child: Text(
                  'Error: ${memoState.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : departmentState.hasError
              ? Center(
                child: Text(
                  'Error: ${departmentState.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Department', style: _labelStyle),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<Department>(
                      value: selectedDepartment,
                      items: [
                        ...departmentList.map(
                          (dept) => DropdownMenuItem(
                            value: dept,
                            child: Text(dept.name),
                          ),
                        ),
                      ],
                      onChanged: (dept) {
                        setState(() {
                          selectedDepartment = dept;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      hint: const Text('Select Department'),
                    ),
                    const SizedBox(height: 16),
                    Text('Memo Title', style: _labelStyle),
                    const SizedBox(height: 4),
                    CustomTextField(
                      controller: titleController,
                      hintText: 'Enter Memo Title',
                      onChange: (_) {},
                    ),
                    const SizedBox(height: 16),
                    Text('Description', style: _labelStyle),
                    const SizedBox(height: 4),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: 'Enter Description',
                      onChange: (_) {},
                    ),
                    const Spacer(),
                    LargeButton(
                      text: 'Create Memo',
                      onPressed: () async {
                        final title = titleController.text.trim();
                        final description = descriptionController.text.trim();

                        if (selectedDepartment == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a department'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (title.isEmpty || description.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (title.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Memo title must be at least 3 characters',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        try {
                          await controller.createMemo(
                            title: title,
                            description: description,
                            departmentId: selectedDepartment!.id,
                          );
                          context.pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to create memo: $e'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
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
