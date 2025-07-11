import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/view/pages/check_in_out_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/festival/view/pages/festival_leaves_screen.dart';
import 'package:office/features/leaves/view/pages/leave_application_screen.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/custom_card.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class HomeScreen extends ConsumerWidget {
  static const route = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Morning ${user.name},',
              subTitle: 'Let\'s be productive',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Actions',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 17),
                  Expanded(
                    child: StaggeredGrid.extent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      mainAxisSpacing: 17,
                      crossAxisSpacing: 9,
                      children: [
                        // StaggeredGridTile.extent(
                        //   crossAxisCellCount: 2,
                        //   mainAxisExtent: 108,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       user.role == 'admin'
                        //           ? context.push(EmployeeScreen.route)
                        //           : context.push(CheckInOutScreen.route);
                        //     },
                        //     child: CustomCard(
                        //       title:
                        //           user.role == 'admin'
                        //               ? 'Employees Page'
                        //               : 'Check In / Check Out',
                        //       subTitle:
                        //           user.role == 'admin'
                        //               ? 'View your employees'
                        //               : 'Click to Check In / Check Out',
                        //       backgroundColor: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 124,
                          child: GestureDetector(
                            onTap: () {
                              context.push(LeaveApplicationScreen.route);
                            },
                            child: CustomCard(
                              title: 'Leave Applications',
                              subTitle: 'View leave applications',
                            ),
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 124,
                          child: GestureDetector(
                            onTap: () {
                              user.role != 'admin'
                                  ? context.push(
                                    '${EmployeeDetailsScreen.route}?id=${user.id}',
                                  )
                                  : context.push(ManageEmployeeScreen.route);
                            },
                            child: CustomCard(
                              title:
                                  user.role == 'admin'
                                      ? 'Manage Employees'
                                      : 'Profile Page',
                              subTitle:
                                  user.role == 'admin'
                                      ? 'Manage your employees'
                                      : 'View my profile',
                            ),
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 124,
                          child: GestureDetector(
                            onTap: () {
                              context.push(FestivalLeavesScreen.route);
                            },
                            child: CustomCard(
                              title: 'Festival Leaves',
                              subTitle: 'See my chill days',
                            ),
                          ),
                        ),
                      ],
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
