import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/auth/controller/user_controller.dart';
import 'package:office/features/checkin/view/pages/check_in_list_screen.dart';
import 'package:office/features/employee/controller/employee_details_controller.dart';
import 'package:office/features/employee/controller/employee_timeline_controller.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
import 'package:office/features/employee/view/widget/leave_timeline_list.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/shared/models/employee.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/custom_card.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  static const route = '/emp-details';

  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    final employeeModel = EmployeeDetailsController().getEmployeeDetails();
    final leaveTimeline = EmployeeTimeLineController().getEmployeeTimeLine();
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: employeeModel.name,
              subTitle:
                  user.role == 'admin' ? 'Employee Details' : 'Your Details',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 12),
                    StaggeredGrid.extent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 7,
                      children: [
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 2,
                          mainAxisExtent: 172,
                          child: EmployeeInfoCard(
                            name: employeeModel.name,
                            email: employeeModel.email ?? '',
                            phone: employeeModel.phone ?? '',
                            bloodGroup: employeeModel.bloodGroup ?? '',
                            role: employeeModel.role ?? '',
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 96,
                          child: EmployeeLeaveCard(
                            type: 'Approved',
                            count: employeeModel.approvedLeave ?? 3,
                            totalCount: employeeModel.totalLeaves ?? 3,
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 96,
                          child: EmployeeLeaveCard(
                            type: 'unapproved',
                            count: employeeModel.unapprovedLeave ?? 3,
                            totalCount:
                                employeeModel.totalAllowedUnapproved ?? 3,
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 96,
                          child: EmployeeLeaveCard(
                            type: 'remaining',
                            count: employeeModel.remainingLeave ?? 3,
                            totalCount: employeeModel.totalLeaves ?? 3,
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 96,
                          child: GestureDetector(
                            onTap: () {
                              context.go(HomeScreen.route);
                              context.push(CheckInListScreen.route);
                            },
                            child: CustomCard(
                              title: 'Check In details',
                              subTitle: 'View Check In details',
                              isCheckInDetails: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Timeline Of Leaves',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    LeaveTimeLineList(timeLine: leaveTimeline),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
