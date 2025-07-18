import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/controller/check_in_list_controller.dart';
import 'package:office/features/checkin/view/pages/check_in_screen.dart';
import 'package:office/features/checkin/view/pages/check_out_screen.dart';
import 'package:office/features/employee/controller/manage_employee_controller.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
import 'package:office/features/festival/view/pages/festival_leaves_screen.dart';
import 'package:office/features/leaves/controller/leave_application_controller.dart';
import 'package:office/features/leaves/repository/leave_application_repository.dart';
import 'package:office/features/leaves/view/pages/leave_application_screen.dart';
import 'package:office/features/memo/view/memo_screen.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/custom_card.dart';
import 'package:office/shared/widgets/main_text_column.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends ConsumerWidget {
  static const route = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final empState = ref.watch(manageEmployeeControllerProvider);
    final leaveApplicationState = ref.watch(leaveApplicationControllerProvider);
    final checkinState = ref.watch(checkInListControllerProvider(user.id));

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
                              mainAxisExtent: 270,
                              child: EmployeeInfoCard(
                                name: user.name,
                                designation: user.designation,
                                email: user.email,
                                phone: user.phone,
                                bloodGroup: user.bloodGroup,
                                role: user.role,
                                dateOfJoining: user.dateOfJoining,
                                department: user.department,
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

                            leaveApplicationState.when(
                              data: (data) {
                                return checkinState.when(
                                  data: (data) {
                                    List checkIndates = List.generate(
                                      data.length,
                                      (index) {
                                        return data[index];
                                      },
                                    );

                                    return StaggeredGridTile.extent(
                                      crossAxisCellCount: 2,
                                      mainAxisExtent: 350,
                                      child: TableCalendar(
                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime(2000),
                                        lastDay: DateTime(2100),
                                      ),
                                    );
                                  },
                                  error:
                                      (error, stackTrace) =>
                                          Text('checkin cannot be fetched'),
                                  loading:
                                      () => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                );
                              },
                              error: (error, stackTrace) {
                                return StaggeredGridTile.extent(
                                  crossAxisCellCount: 2,
                                  mainAxisExtent: 350,
                                  child: TableCalendar(
                                    focusedDay: DateTime.now(),
                                    firstDay: DateTime(2000),
                                    lastDay: DateTime(2100),
                                  ),
                                );
                              },
                              loading: () {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
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
                            if (user.role != "admin")
                              StaggeredGridTile.extent(
                                crossAxisCellCount: 2,
                                mainAxisExtent: 124,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(MemoListScreen.route);
                                  },
                                  child: CustomCard(
                                    title: 'Memo List',
                                    subTitle: 'See the list of memos',
                                  ),
                                ),
                              ),
                            if (user.role == "admin")
                              StaggeredGridTile.extent(
                                crossAxisCellCount: 2,
                                mainAxisExtent: 124,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(MemoListScreen.route);
                                  },
                                  child: CustomCard(
                                    title: 'Memo Manager',
                                    subTitle: 'Manage the memos',
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
