import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/auth/controller/auth_controller.dart';
import 'package:office/features/leaves/controller/leave_application_controller.dart';
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
    final user = ref.watch(userProvider)!;
    final leaveController = ref.watch(leaveApplicationControllerProvider);
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
              user.role == 'user'
                  ? SizedBox(
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
                  )
                  : null,
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
                  leaveController.when(
                    data: (data) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder:
                              (context, index) => LeaveApplicationTile(
                                name: data[index].name,
                                dateOfLeave: data[index].date,
                                reason: data[index].reason,
                                typeOfLeave: data[index].type,
                                index: index + 1,
                                status: data[index].choice,
                                user: user,
                              ),
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 12),
                          itemCount: data.length,
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    loading: () {
                      return Center(child: CircularProgressIndicator());
                    },
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
