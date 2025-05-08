import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/auth/controller/user_controller.dart';
import 'package:office/features/leaves/view/pages/create_leave_screen.dart';
import 'package:office/features/leaves/view/widgets/leave_application_tile.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class LeaveApplicationScreen extends ConsumerWidget {
  static final route = '/leave';

  const LeaveApplicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          floatingActionButton:
              user.role == 'user' ? SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    context.push(CreateLeaveScreen.route);
                  },
                  shape: CircleBorder(),
                  backgroundColor: Palette.primaryColor,
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ) : null,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.endContained,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Leave Application',
              subTitle:
                  user.role == 'admin'
                      ? 'Provide leave for your employees'
                      : 'Your applications',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Leave Application List',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:
                          (context, index) => LeaveApplicationTile(
                            name: 'Abdur Rahman',
                            dateOfLeave: '12/12/2025',
                            reason: 'lorem ipsum',
                            remainingLeave: '21',
                            totalApprovedLeaves: '4',
                            totalUnApprovedLeaves: '3',
                            typeOfLeave: 'Casual',
                            index: index + 1,
                            status: 'Accepted',
                            user: user,
                          ),
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 12),
                      itemCount: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
