import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/controller/check_in_list_controller.dart';
import 'package:office/features/checkin/view/pages/check_in_screen.dart';
import 'package:office/features/checkin/view/pages/check_out_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
import 'package:office/features/festival/view/pages/festival_leaves_screen.dart';
import 'package:office/features/leaves/controller/leave_application_controller.dart';
import 'package:office/features/leaves/model/leave_application_model.dart';
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
                                List<List> choice = [];
                                for (LeaveApplicationModel model in data) {
                                  choice.add([
                                    model.date.split('T')[0],
                                    model.choice,
                                  ]);
                                }

                                return checkinState.when(
                                  data: (checkinData) {
                                    final Map<DateTime, Color> dateColors = {};

                                    for (var e in checkinData) {
                                      final parts = e.date.split('/');
                                      final date = DateTime(
                                        int.parse(parts[2]),
                                        int.parse(parts[1]),
                                        int.parse(parts[0]),
                                      );

                                      final timeParts = e.time.split(':');
                                      final checkinTime = TimeOfDay(
                                        hour: int.parse(timeParts[0]),
                                        minute: int.parse(timeParts[1]),
                                      );

                                      final start = const TimeOfDay(
                                        hour: 9,
                                        minute: 40,
                                      );
                                      final end = const TimeOfDay(
                                        hour: 18,
                                        minute: 0,
                                      );

                                      bool isBetween(
                                        TimeOfDay t,
                                        TimeOfDay start,
                                        TimeOfDay end,
                                      ) {
                                        final totalMinutes =
                                            t.hour * 60 + t.minute;
                                        final startMinutes =
                                            start.hour * 60 + start.minute;
                                        final endMinutes =
                                            end.hour * 60 + end.minute;
                                        return totalMinutes >= startMinutes &&
                                            totalMinutes <= endMinutes;
                                      }

                                      if (isBetween(checkinTime, start, end)) {
                                        dateColors[DateTime(
                                              date.year,
                                              date.month,
                                              date.day,
                                            )] =
                                            Colors.orange;
                                      } else {
                                        dateColors[DateTime(
                                              date.year,
                                              date.month,
                                              date.day,
                                            )] =
                                            Colors.green;
                                      }
                                    }

                                    for (var c in choice) {
                                      final dateParts = c[0].split('-');
                                      final leaveDate = DateTime(
                                        int.parse(dateParts[0]),
                                        int.parse(dateParts[1]),
                                        int.parse(dateParts[2]),
                                      );

                                      final leaveStatus = c[1];
                                      if (leaveStatus == 'accepted') {
                                        dateColors[leaveDate] = Colors.blue;
                                      } else if (leaveStatus == 'denied') {
                                        dateColors[leaveDate] = Colors.red;
                                      }
                                    }

                                    return StaggeredGridTile.extent(
                                      crossAxisCellCount: 2,
                                      mainAxisExtent: 350,
                                      child: TableCalendar(
                                        headerStyle: const HeaderStyle(
                                          formatButtonVisible: false,
                                        ),
                                        calendarStyle: const CalendarStyle(
                                          outsideDaysVisible: false,
                                          defaultDecoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime(2000),
                                        lastDay: DateTime(2100),
                                        calendarFormat: CalendarFormat.month,

                                        calendarBuilders: CalendarBuilders(
                                          headerTitleBuilder: (context, day) {
                                            final daysInMonth =
                                                DateUtils.getDaysInMonth(
                                                  day.year,
                                                  day.month,
                                                );

                                            final totalPresent =
                                                dateColors.keys
                                                    .where(
                                                      (d) =>
                                                          d.year == day.year &&
                                                          d.month == day.month,
                                                    )
                                                    .length;

                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${DateFormat.MMMM().format(day)} ${day.year}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  '$totalPresent / $daysInMonth ',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          defaultBuilder: (
                                            context,
                                            day,
                                            focusedDay,
                                          ) {
                                            final today = DateTime.now();
                                            final dateOnly = DateTime(
                                              day.year,
                                              day.month,
                                              day.day,
                                            );

                                            // Skip coloring for future days
                                            if (dateOnly.isAfter(
                                              DateTime(
                                                today.year,
                                                today.month,
                                                today.day,
                                              ),
                                            )) {
                                              return Center(
                                                child: Text(
                                                  '${day.day}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            }

                                            final color = dateColors[dateOnly];

                                            return Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    color ?? Colors.transparent,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${day.day}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  error:
                                      (error, stackTrace) => const Text(
                                        'checkin cannot be fetched',
                                      ),
                                  loading:
                                      () => const Center(
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
                                return const Center(
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
