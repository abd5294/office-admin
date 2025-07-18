import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/memo/model/department_model.dart';
import 'package:office/features/memo/controller/department_controller.dart'; // <-- Import controller
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateDepartmentScreen extends ConsumerStatefulWidget {
  static final route = '/create-department';

  const CreateDepartmentScreen({super.key});

  @override
  ConsumerState<CreateDepartmentScreen> createState() =>
      _CreateDepartmentScreenState();
}

class _CreateDepartmentScreenState
    extends ConsumerState<CreateDepartmentScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final departmentState = ref.watch(departmentControllerProvider);
    final controller = ref.read(departmentControllerProvider.notifier);

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
          'Create Department',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body:
          departmentState.isLoading
              ? const Center(child: CircularProgressIndicator())
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
                    Text('Department Name', style: _labelStyle),
                    const SizedBox(height: 4),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Enter Department name',
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
                      text: 'Create Department',
                      onPressed: () async {
                        final name = nameController.text.trim();
                        final description = descriptionController.text.trim();

                        if (name.isEmpty || description.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (name.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Department name must be at least 3 characters',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        final model = Department(
                          id: 0,
                          name: name,
                          description: description,
                        );

                        try {
                          await controller.createDepartment(model);
                          context.pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to create department: $e'),
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
