import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/controller/employee_details_controller.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
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
    final employeeDetailsState = ref.watch(
      employeeDetailsControllerProvider(user.id),
    );
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
              user.role == 'employee'
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Leave Stats',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 12),

                    employeeDetailsState.when(
                      data: (data) {
                        final remainingLeaves = data.leaves['remaining_leaves'];
                        final leavesTaken = data.leaves['total_leaves_taken'];
                        final totalLeaves = remainingLeaves + leavesTaken;
                        return StaggeredGrid.extent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 7,
                          children: [
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 2,
                              mainAxisExtent: 96,
                              child: EmployeeLeaveCard(
                                type: 'Total Leaves',
                                count: data.leaves['approved_leaves'],
                                totalCount: totalLeaves,
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 96,
                              child: EmployeeLeaveCard(
                                type: 'Leaves Taken',
                                count: data.leaves['unapproved_leaves'],
                                totalCount: leavesTaken,
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 96,
                              child: EmployeeLeaveCard(
                                type: 'Leaves Remaining',
                                count: data.leaves['remaining_leaves'],
                                totalCount: remainingLeaves,
                              ),
                            ),
                          ],
                        );
                      },
                      error:
                          (error, stackTrace) =>
                              Center(child: Text('An Error Occurred')),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(height: 16),
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
                        if (user.role == 'admin') {
                          data =
                              data
                                  .where(
                                    (element) => element.choice == 'undecided',
                                  )
                                  .toList();
                        } else {
                          data =
                              data
                                  .where((element) => element.name == user.name)
                                  .toList();
                        }
                        if (data.isEmpty) {
                          return Center(
                            child: Text(
                              'No items found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder:
                                (context, index) => LeaveApplicationTile(
                                  name: data[index].name,
                                  dateOfLeave: data[index].date,
                                  reason: data[index].reason,
                                  kind: data[index].kind,
                                  typeOfLeave: data[index].type,
                                  index: index + 1,
                                  status: data[index].choice,
                                  user: user,
                                  id: data[index].id,
                                  comment: data[index].comment,
                                ),
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 12),
                            itemCount: data.length,
                          );
                        }
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
      ),
    );
  }
}
