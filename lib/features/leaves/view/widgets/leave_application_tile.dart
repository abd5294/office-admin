import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/auth/model/user_model.dart';
import 'package:office/features/leaves/controller/leave_application_controller.dart';
import 'package:office/features/leaves/model/leave_application_model.dart';
import 'package:office/shared/widgets/custom_alert_dialog.dart';

class LeaveApplicationTile extends ConsumerStatefulWidget {
  final String name;
  final String reason;
  final String status;
  final String dateOfLeave;
  final String typeOfLeave;
  final int index;
  final UserModel user;
  final int id;

  const LeaveApplicationTile({
    super.key,
    required this.index,
    required this.status,
    required this.name,
    required this.user,
    required this.reason,
    required this.dateOfLeave,
    required this.typeOfLeave,
    required this.id,
  });

  @override
  ConsumerState<LeaveApplicationTile> createState() =>
      _LeaveApplicationTileState();
}

class _LeaveApplicationTileState extends ConsumerState<LeaveApplicationTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final leaveController = ref.read(
      leaveApplicationControllerProvider.notifier,
    );
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
                const BoxShadow(
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
                          style: const TextStyle(
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
                    Text(
                      'Employee Name',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withAlpha(123),
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
                            padding: EdgeInsets.all(2),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      widget.user.role == 'admin'
                          ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    title: 'Cancel Application?',
                                    subTitle:
                                        'Are you sure you want to cancel this application?',
                                    buttonText: 'Reject',
                                    onPressed: () {
                                      final updatedLeave =
                                          LeaveApplicationModel(
                                            name: widget.name,
                                            reason: widget.reason,
                                            type: widget.typeOfLeave,
                                            date: widget.dateOfLeave,
                                            choice: 'denied',
                                            id: widget.id,
                                          );
                                      leaveController.updateLeaveApplication(
                                        updatedLeave,
                                      );
                                      context.pop();
                                    },
                                  );
                                },
                              );
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                          : GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    widget.status == 'accepted'
                                        ? Colors.green
                                        : widget.status == 'undecided'
                                        ? Colors.orange
                                        : Colors.red,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                widget.status == 'accepted'
                                    ? Icons.check
                                    : Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      const SizedBox(width: 12),
                      widget.user.role == 'admin'
                          ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    title: 'Accept Application?',
                                    subTitle:
                                        'Are you sure you want to Accept this application?',
                                    buttonText: 'Accept',
                                    onPressed: () {
                                      final updatedLeave =
                                          LeaveApplicationModel(
                                            name: widget.name,
                                            reason: widget.reason,
                                            type: widget.typeOfLeave,
                                            date: widget.dateOfLeave,
                                            choice: 'accepted',
                                            id: widget.id,
                                          );
                                      leaveController.updateLeaveApplication(
                                        updatedLeave,
                                      );
                                      context.pop();
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                          : GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.delete_outline,
                                size: 16,
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
                    ? LeaveApplicationExpandedTile(
                      name: widget.name,
                      user: widget.user,
                      status: widget.status,
                      reason: widget.reason,
                      dateOfLeave: widget.dateOfLeave,
                      typeOfLeave: widget.typeOfLeave,
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class LeaveApplicationExpandedTile extends StatelessWidget {
  final String name;
  final String reason;
  final String status;
  final UserModel user;
  final String dateOfLeave;
  final String typeOfLeave;

  const LeaveApplicationExpandedTile({
    super.key,
    required this.user,
    required this.name,
    required this.status,
    required this.reason,
    required this.dateOfLeave,
    required this.typeOfLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      decoration: const BoxDecoration(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                user.role == 'employee'
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            color:
                                status == 'accepted'
                                    ? Colors.green
                                    : status == 'undecided'
                                    ? Colors.orange
                                    : Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.grey.shade600,
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
                  'Reason',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Date of leave',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  dateOfLeave,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Type of leave',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  typeOfLeave,
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
