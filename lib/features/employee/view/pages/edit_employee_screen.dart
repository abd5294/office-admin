import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/features/employee/controller/manage_employee_controller.dart';
import 'package:office/features/employee/models/update_employee_model.dart';
import 'package:office/shared/widgets/custom_text_field.dart';
import 'package:office/shared/widgets/large_button.dart';

class EditEmployeeScreen extends ConsumerStatefulWidget {
  static final route = '/edit-emp';

  final int id;
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String designation;
  final String address;
  final String gender;
  final String dob;
  final String emergencyContacts;

  const EditEmployeeScreen({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.designation,
    required this.address,
    required this.gender,
    required this.dob,
    required this.emergencyContacts,
  });

  @override
  ConsumerState<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends ConsumerState<EditEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final emergencyContactsController = TextEditingController();
  final List<String> options = ['Male', 'Female', 'Others'];
  final List<String> bloodGroupOptions = [
    'A+',
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
  bool isDeactivated = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    bloodGroupController.text = widget.bloodGroup;

    designationController.text = widget.designation;
    addressController.text = widget.address;
    genderController.text = widget.gender;
    dobController.text = widget.dob;
    emergencyContactsController.text = widget.emergencyContacts;
    selectedGender = capitalize(widget.gender);
    selectedBloodGroup = widget.bloodGroup;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bloodGroupController.dispose();
    designationController.dispose();
    addressController.dispose();
    genderController.dispose();
    dobController.dispose();
    emergencyContactsController.dispose();
    super.dispose();
  }

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
          'Edit Employee',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: nameController,
                hintText: 'Enter employee\'s name',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter employee\'s Email',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Designation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: designationController,
                hintText: 'Enter employee\'s designation',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: addressController,
                hintText: 'Enter employee\'s address',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'DOB',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'Select Date of Birth',
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
                    initialDate:
                        dobController.text.isNotEmpty
                            ? DateTime.tryParse(
                                  dobController.text,
                                )?.toLocal() ??
                                DateTime(2000)
                            : DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    // Store in UTC ISO string
                    dobController.text = pickedDate.toUtc().toIso8601String();
                    setState(() {}); // To refresh the displayed value
                  }
                },
                // Show local date in the field
                // Use buildCounter as a hack to format the display value
                // Or use a ValueListenableBuilder/another controller, but for simplicity:
              ),
              // Show the local formatted date below the field if dobController has value
              if (dobController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                  child: Text(
                    // Parse UTC and show in local
                    () {
                      try {
                        final utcDate =
                            DateTime.parse(dobController.text).toUtc();
                        final localDate = utcDate.toLocal();
                        return "Local Date: ${localDate.year.toString().padLeft(4, '0')}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}";
                      } catch (_) {
                        return "Local Date: ${dobController.text}";
                      }
                    }(),
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  ),
                ),
              const SizedBox(height: 8),

              const Text(
                'Phone',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: phoneController,
                hintText: 'Enter employee\'s Phone Number',
                onChange: (value) {},
              ),
              const SizedBox(height: 8),

              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              const SizedBox(height: 4),
              DropdownButton<String>(
                hint: Text("Select Gender"),
                value: selectedGender,
                onChanged: (String? newValue) {
                  genderController.text = newValue!.toLowerCase();
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                items:
                    options.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 8),

              const Text(
                'Blood Group',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
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
              const Text(
                'Employee Status (Deactivated)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F3036),
                ),
              ),
              Switch(
                value: isDeactivated,
                onChanged: (bool value) {
                  setState(() {
                    isDeactivated = !isDeactivated;
                  });
                },
              ),

              const SizedBox(height: 8),
              LargeButton(
                text: 'Edit Employee',
                onPressed: () {
                  final updatedEmployee = UpdateEmployeeModel(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    bloodGroup: bloodGroupController.text.trim(),
                    gender: genderController.text.trim(),
                    designation: designationController.text.trim(),
                    address: addressController.text.trim(),
                    dob: dobController.text.trim(),
                    isDeactivated: isDeactivated,
                  );
                  try {
                    empState.updateEmployee(updatedEmployee, widget.id);
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
}
