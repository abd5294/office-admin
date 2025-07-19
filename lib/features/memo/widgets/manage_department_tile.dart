import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/memo/model/department_model.dart';

class ManageDepartmentTile extends StatelessWidget {
  final int count;
  final Department department;
  final VoidCallback onDelete;

  const ManageDepartmentTile({
    super.key,
    required this.count,
    required this.department,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/memo-by-dept', extra: department);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                // BoxShadow(
                //   color: Colors.black12,
                //   spreadRadius: 3,
                //   blurRadius: 15,
                // ),
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
                          count.toString(),
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
                      'Department Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      department.name,
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
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.push('/edit-department', extra: department);
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
                        onTap: onDelete,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.push('/memo-by-dept', extra: department);
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
        ],
      ),
    );
  }
}
