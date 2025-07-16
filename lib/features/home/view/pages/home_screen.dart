import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/view/pages/check_in_screen.dart';
import 'package:office/features/checkin/view/pages/check_out_screen.dart';
import 'package:office/features/employee/controller/manage_employee_controller.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
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
    final empState = ref.watch(manageEmployeeControllerProvider);
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
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: MainTextColumn(
              title: 'Hi ${user.name},',
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
                    child: ListView(
                      children: [
                        StaggeredGrid.extent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          mainAxisSpacing: 17,
                          crossAxisSpacing: 9,
                          children: [
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 2,
                              mainAxisExtent: 204,
                              child: EmployeeInfoCard(
                                name: user.name,
                                designation: user.designation,
                                email: user.email,
                                phone: user.phone,
                                bloodGroup: user.bloodGroup,
                                role: user.role,
                              ),
                            ),
                            user.role == "admin"
                                ? StaggeredGridTile.extent(
                                  crossAxisCellCount: 2,
                                  mainAxisExtent: 108,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push(EmployeeScreen.route);
                                    },
                                    child: CustomCard(
                                      title: 'ThePilot.in Crew Page',
                                      subTitle: 'View your crew members',
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                )
                                : StaggeredGridTile.extent(
                                  crossAxisCellCount: 1,
                                  mainAxisExtent: 108,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push(CheckInScreen.route);
                                    },
                                    child: CustomCard(
                                      title: 'Check In',
                                      subTitle: 'Mark your Checkin',
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                            if (user.role != "admin")
                              StaggeredGridTile.extent(
                                crossAxisCellCount: 1,
                                mainAxisExtent: 108,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(CheckOutScreen.route);
                                  },
                                  child: CustomCard(
                                    title: 'Check Out',
                                    subTitle: 'Mark your Checkout',
                                    backgroundColor: Colors.black,
                                  ),
                                ),
                              ),

                            StaggeredGridTile.extent(
                              crossAxisCellCount: 2,
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
                              crossAxisCellCount: 2,
                              mainAxisExtent: 124,
                              child: GestureDetector(
                                onTap: () {
                                  user.role != 'admin'
                                      ? context.push(
                                        '${EmployeeDetailsScreen.route}?id=${user.id}',
                                      )
                                      : context.push(
                                        ManageEmployeeScreen.route,
                                      );
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
                              crossAxisCellCount: 2,
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
