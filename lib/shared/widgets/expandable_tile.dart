import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';

class ExpandableTile extends StatefulWidget {
  final String employeeName;
  final int index;
  final int attendance;

  const ExpandableTile({
    super.key,
    required this.employeeName,
    required this.index,
    required this.attendance,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 6,
                  blurRadius: 15,
                  offset: Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
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
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Name',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      widget.employeeName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.push(EmployeeDetailsScreen.route);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
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
                    ? ExpandedTile(attendance: widget.attendance.toString())
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class ExpandedTile extends StatelessWidget {
  final String attendance;

  const ExpandedTile({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Column(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF006FFD),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 38,
                    width: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$attendance%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Text(
                  'Attendance',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
