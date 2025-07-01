import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/festival/controller/festival_leave_contorller.dart';
import 'package:office/features/festival/view/pages/create_festival_screen.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';
import 'package:table_calendar/table_calendar.dart';

class FestivalLeavesScreen extends ConsumerWidget {
  static const route = '/festival-leaves';

  const FestivalLeavesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final leaveState = ref.watch(festivalLeaveControllerProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton:
              user.role == 'admin'
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 23.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: FloatingActionButton(
                        onPressed: () {
                          context.push(CreateFestivalScreen.route);
                        },
                        shape: const CircleBorder(),
                        backgroundColor: Palette.primaryColor,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                  : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          appBar: const PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const MainTextColumn(
              title: 'Festival Leaves',
              subTitle: 'Enjoy your holidays!',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Timeline of leaves',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: leaveState.when(
                      data: (leaves) {
                        final dateFormat = DateFormat('dd-MM-yyyy');
                        final holidayString = leaves.map(
                          (e) => dateFormat.format(DateTime.parse(e.date)),
                        );

                        final _holidays =
                            holidayString.map((str) {
                              final dt = dateFormat.parse(str);
                              return DateTime.utc(
                                dt.year,
                                dt.month,
                                dt.day,
                              ); // Normalize
                            }).toSet();

                        bool _isHoliday(DateTime day) {
                          final normalized = DateTime.utc(
                            day.year,
                            day.month,
                            day.day,
                          );
                          return _holidays.contains(normalized);
                        }

                        return TableCalendar(
                          headerStyle: HeaderStyle(formatButtonVisible: false),
                          focusedDay: DateTime.now(),
                          firstDay: DateTime.utc(2020, 1, 1),
                          lastDay: DateTime.utc(2040, 12, 31),
                          holidayPredicate: _isHoliday,
                          calendarBuilders: CalendarBuilders(
                            todayBuilder: (context, day, focusedDay) {
                              return Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color:
                                      Palette.primaryColor, // Your custom color
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${day.day}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            holidayBuilder: (context, day, focusedDay) {
                              return Container(
                                margin: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${day.day}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (error, _) => Center(
                            child: Text(
                              'Failed to load festival leaves',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
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
