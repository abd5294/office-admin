import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/checkin/controller/check_in_individual_controller.dart';
import 'package:office/features/checkin/view/widgets/detail_check_in.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class CheckInIndividualScreen extends ConsumerWidget {
  static const route = '/check-in-individual';
  final int id;

  const CheckInIndividualScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkInState = ref.watch(checkInIndividualControllerProvider(id));
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: checkInState.when(
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
                  title: data[0].name,
                  subTitle: 'Check In details for the day',
                ),
              ),
              bottomSheet: CustomBottomSheet(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Check In Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder:
                            (context, index) => DetailCheckIn(
                              time: data[index].time,
                              session: 'AM',
                              totalBottomCount: 23,
                              totalTopCount: 23,
                            ),
                        separatorBuilder:
                            (context, index) => SizedBox(height: 12),
                        itemCount: data.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text('An Error occurred'));
          },
          loading: () {
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
