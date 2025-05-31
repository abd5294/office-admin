import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/view/pages/edit_employee_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';

class ManageEmployeeTile extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String role;
  final String designation;
  final String address;
  final String gender;
  final String dob;
  final List<dynamic> emergencyContacts;
  final int index;

  const ManageEmployeeTile({
    super.key,
    required this.id,
    required this.index,
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.role,
    required this.designation,
    required this.address,
    required this.gender,
    required this.dob,
    required this.emergencyContacts,
  });

  @override
  State<ManageEmployeeTile> createState() => _ManageEmployeeTileState();
}

class _ManageEmployeeTileState extends State<ManageEmployeeTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bloodGroup = widget.bloodGroup;
    final encodedBloodGroup = Uri.encodeComponent(bloodGroup);

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 3,
                  blurRadius: 15,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                ClipRRect(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          widget.index.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                            '${EditEmployeeScreen.route}'
                            '?id=${widget.id}'
                            '&name=${widget.name}'
                            '&email=${widget.email}'
                            '&phone=${widget.phone}'
                            '&bloodGroup=$encodedBloodGroup'
                            '&role=${widget.role}'
                            '&designation=${widget.designation}'
                            '&address=${widget.address}'
                            '&gender=${widget.gender}'
                            '&dob=${widget.dob}'
                            '&emergencyContacts=${widget.emergencyContacts}',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(6),
                          child: const Icon(
                            Icons.edit_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.push(
                            '${EmployeeDetailsScreen.route}?id=${widget.id}',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child:
                isExpanded
                    ? ManageEmployeeExpandedTile(
                      name: widget.name,
                      email: widget.email,
                      phone: widget.phone,
                      bloodGroup: widget.bloodGroup,
                      role: widget.role,
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class ManageEmployeeExpandedTile extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String role;

  const ManageEmployeeExpandedTile({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12)],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.black.withAlpha(123),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.black.withAlpha(123),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Phone',
                  style: TextStyle(
                    color: Colors.black.withAlpha(123),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Blood Group',
                  style: TextStyle(
                    color: Colors.black.withAlpha(123),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  bloodGroup,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Role',
                  style: TextStyle(
                    color: Colors.black.withAlpha(123),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
