import 'package:flutter/material.dart';

class EmployeeInfoCard extends StatelessWidget {
  final String name;
  final String designation;
  final String email;
  final String phone;
  final String bloodGroup;
  final String role;
  final String department;
  final String dateOfJoining;

  const EmployeeInfoCard({
    super.key,
    required this.name,
    required this.designation,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.role,
    required this.department,
    required this.dateOfJoining,
  });

  @override
  Widget build(BuildContext context) {
    String dateStr = dateOfJoining;
    String formatted = dateStr.split("T")[0];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
              'Designation',
              style: TextStyle(
                color: Colors.black.withAlpha(123),
                fontSize: 8,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              designation,
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
            Text(
              'Department',
              style: TextStyle(
                color: Colors.black.withAlpha(123),
                fontSize: 8,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              department,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              'Date of joining',
              style: TextStyle(
                color: Colors.black.withAlpha(123),
                fontSize: 8,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              formatted,
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
    );
  }
}

class EmployeeLeaveCard extends StatelessWidget {
  final String type;
  final int totalCount;
  final dynamic count;

  const EmployeeLeaveCard({
    super.key,
    required this.type,
    required this.totalCount,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  totalCount.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Leaves',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
