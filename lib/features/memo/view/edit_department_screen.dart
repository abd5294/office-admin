import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/memo/model/department_model.dart';
import 'package:office/features/memo/controller/department_controller.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class EditDepartmentScreen extends ConsumerStatefulWidget {
  static const route = '/edit-department';
  final Department department;

  const EditDepartmentScreen({super.key, required this.department});

  @override
  ConsumerState<EditDepartmentScreen> createState() =>
      _EditDepartmentScreenState();
}

class _EditDepartmentScreenState extends ConsumerState<EditDepartmentScreen> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.department.name);
    descriptionController = TextEditingController(
      text: widget.department.description,
    );
  }

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
          'Edit Department',
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
                      text: 'Update Department',
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

                        final updatedDepartment = Department(
                          id: widget.department.id,
                          name: name,
                          description: description,
                        );

                        try {
                          await controller.updateDepartment(
                            widget.department.id,
                            updatedDepartment,
                          );
                          context.pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update department: $e'),
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
