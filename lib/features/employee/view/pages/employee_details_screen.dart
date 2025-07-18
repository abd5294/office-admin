import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/controller/employee_details_controller.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class EmployeeDetailsScreen extends ConsumerStatefulWidget {
  static const route = '/emp-details';
  final int id;

  const EmployeeDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<EmployeeDetailsScreen> createState() =>
      _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends ConsumerState<EmployeeDetailsScreen> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final employeeDetailsState = ref.watch(
      employeeDetailsControllerProvider(widget.id),
    );
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: employeeDetailsState.when(
          data: (data) {
            final remainingLeaves = data.leaves['remaining_leaves'];
            final leavesTaken = data.leaves['total_leaves_taken'];
            final totalLeaves = remainingLeaves + leavesTaken;
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
                              mainAxisExtent: 270,
                              child: EmployeeInfoCard(
                                name: data.user['name'],
                                email: data.user['email'],
                                phone: data.user['phone'],
                                bloodGroup: data.user['bloodType'],
                                designation: data.user['designation'],
                                role: data.user['role'],
                                dateOfJoining: user.dateOfJoining,
                                department: user.department,
                              ),
                            ),
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 2,
                              mainAxisExtent: 35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Leave Stats',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isVisible
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _isVisible
                                ? StaggeredGridTile.extent(
                                  crossAxisCellCount: 2,
                                  mainAxisExtent: 96,
                                  child: EmployeeLeaveCard(
                                    type: 'Total Leaves',
                                    count: data.leaves['approved_leaves'],
                                    totalCount: totalLeaves,
                                  ),
                                )
                                : SizedBox.shrink(),

                            _isVisible
                                ? StaggeredGridTile.extent(
                                  crossAxisCellCount: 1,
                                  mainAxisExtent: 96,
                                  child: EmployeeLeaveCard(
                                    type: 'Leaves Taken',
                                    count: data.leaves['unapproved_leaves'],
                                    totalCount: leavesTaken,
                                  ),
                                )
                                : SizedBox.shrink(),

                            _isVisible
                                ? StaggeredGridTile.extent(
                                  crossAxisCellCount: 1,
                                  mainAxisExtent: 96,
                                  child: EmployeeLeaveCard(
                                    type: 'Leaves Remaining',
                                    count: data.leaves['remaining_leaves'],
                                    totalCount: remainingLeaves,
                                  ),
                                )
                                : SizedBox.shrink(),
                          ],
                        ),
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
