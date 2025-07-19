import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/controller/check_in_list_controller.dart';
import 'package:office/features/employee/controller/employee_details_controller.dart';
import 'package:office/features/employee/view/widget/employee_card.dart';
import 'package:office/features/leaves/controller/leave_application_controller.dart';
import 'package:office/features/leaves/model/leave_application_model.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';
import 'package:table_calendar/table_calendar.dart';

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

    final leaveApplicationState = ref.watch(leaveApplicationControllerProvider);
    final checkinState = ref.watch(checkInListControllerProvider(user.id));
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
