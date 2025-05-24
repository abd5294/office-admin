import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/view/pages/check_in_list_screen.dart';
import 'package:office/features/employee/controller/employee_details_controller.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
import 'package:office/features/employee/view/widget/leave_timeline_list.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/custom_card.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  static const route = '/emp-details';
  final int id;

  const EmployeeDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    final employeeDetailsState = ref.watch(
      employeeDetailsControllerProvider(id),
    );
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: employeeDetailsState.when(
          data: (data) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: const PreferredSize(
                preferredSize: Size(0, 74),
                child: CustomAppBar(),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MainTextColumn(
                  title: data.user['name'],
                  subTitle:
                      user.role == 'admin'
                          ? 'Employee Details'
                          : 'Your Details',
                ),
              ),
              bottomSheet: CustomBottomSheet(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Employee Details',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        StaggeredGrid.extent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 7,
                          children: [
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 2,
                              mainAxisExtent: 172,
                              child: EmployeeInfoCard(
                                name: data.user['name'],
                                email: data.user['email'],
                                phone: data.user['phone'],
                                bloodGroup: data.user['bloodType'],
                                role: data.user['role'],
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 96,
                              child: EmployeeLeaveCard(
                                type: 'Approved',
                                count: data.leaves['approved_leaves'],
                                totalCount: data.leaves['total_leaves_taken'],
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 96,
                              child: EmployeeLeaveCard(
                                type: 'unapproved',
                                count: data.leaves['unapproved_leaves'],
                                totalCount: data.leaves['total_leaves_taken'],
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 96,
                              child: EmployeeLeaveCard(
                                type: 'remaining',
                                count: data.leaves['remaining_leaves'],
                                totalCount: data.leaves['total_leaves_taken'],
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 96,
                              child: GestureDetector(
                                onTap: () {
                                  context.push(
                                    '${CheckInListScreen.route}?id=$id&name=${data.user['name']}',
                                  );
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
                        const SizedBox(height: 12),
                        const Text(
                          'Timeline Of Leaves',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LeaveTimeLineList(timeLine: data.holidays),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return SizedBox.shrink();
          },
          loading: () {
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
