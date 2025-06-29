import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/features/employee/controller/manage_employee_controller.dart';
import 'package:office/features/employee/models/create_employee_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class CreateEmployeeScreen extends ConsumerStatefulWidget {
  static final route = '/create-emp';

  const CreateEmployeeScreen({super.key});

  @override
  ConsumerState<CreateEmployeeScreen> createState() =>
      _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends ConsumerState<CreateEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final employeeIDController = TextEditingController();
  final totalLeavesController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final emergencyContactsController = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female', 'Others'];
  final List<String> bloodGroupOptions = [
    'B+',
    'B+',
    'AB+',
    'O+',
    'A-',
    'B-',
    'AB-',
    'O- ',
  ];
  String? selectedGender;
  String? selectedBloodGroup;

  @override
  Widget build(BuildContext context) {
    final empState = ref.watch(manageEmployeeControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Palette.primaryColor,
          ),
        ),
        title: const Text(
          'Create Employee',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: nameController,
                hintText: 'Enter employee\'s name',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const SizedBox(height: 4),

              const Text('Email', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter employee\'s Email',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Password', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter employee\'s Password',
                onChange: (value) {},
                isObscured: true,
              ),
              const SizedBox(height: 8),

              const Text('Employee ID', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: employeeIDController,
                hintText: 'Enter employee\'s ID',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Total Leaves', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: totalLeavesController,
                hintText: 'Enter employee\'s total leaves',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Designation', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: designationController,
                hintText: 'Enter employee\'s designation',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Address', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: addressController,
                hintText: 'Enter employee\'s address',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('Blood Group', style: _labelStyle),
              const SizedBox(height: 4),
              DropdownButton<String>(
                hint: const Text("Select Blood Group"),
                value: selectedBloodGroup,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    bloodGroupController.text = newValue;
                    setState(() {
                      selectedBloodGroup = newValue;
                    });
                  }
                },
                items:
                    bloodGroupOptions.map((String bloodType) {
                      return DropdownMenuItem<String>(
                        value: bloodType,
                        child: Text(bloodType),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 8),

              const Text('Gender', style: _labelStyle),
              const SizedBox(height: 4),
              DropdownButton<String>(
                hint: const Text("Select Gender"),
                value: selectedGender,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    genderController.text = newValue.toLowerCase();
                    setState(() {
                      selectedGender = newValue;
                    });
                  }
                },
                items:
                    genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 8),

              const Text('Phone', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: phoneController,
                hintText: 'Enter employee\'s phone number',
                isNumeric: true,
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text('DOB', style: _labelStyle),
              const SizedBox(height: 4),

              TextField(
                controller: dobController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'Select Date of Birth',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    final formattedDate =
                        DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                        ).toUtc().toIso8601String();

                    dobController.text = formattedDate;
                  }
                },
              ),

              const SizedBox(height: 8),

              const Text('Emergency Contacts', style: _labelStyle),
              const SizedBox(height: 4),
              CustomTextField(
                controller: emergencyContactsController,
                hintText: 'Enter contact numbers (comma separated)',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              LargeButton(
                text: 'Add Employee',
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      employeeIDController.text.isEmpty ||
                      totalLeavesController.text.isEmpty ||
                      designationController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      bloodGroupController.text.isEmpty ||
                      genderController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      dobController.text.isEmpty ||
                      emergencyContactsController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (phoneController.text.length < 10 ||
                      phoneController.text.length > 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Phone number must be of 10 digits'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final newEmployee = CreateEmployeeModel(
                    name: nameController.text.trim(),
                    role: 'employee',
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    employeeID: employeeIDController.text.trim(),
                    totalLeaves:
                        int.tryParse(totalLeavesController.text.trim()) ?? 0,
                    designation: designationController.text.trim(),
                    address: addressController.text.trim(),
                    bloodType: bloodGroupController.text.trim(),
                    gender: genderController.text.trim(),
                    phone: phoneController.text.trim(),
                    dob: dobController.text.trim(),
                    emergencyContacts:
                        emergencyContactsController.text
                            .trim()
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                  );
                  try {
                    empState.createEmployee(newEmployee);
                    showSnackBar(context, 'Update Successful');
                  } catch (e) {
                    showSnackBar(context, "Edit Employee Failed");
                  }
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  static const _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2F3036),
  );
}
