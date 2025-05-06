import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/checkin/view/widgets/detail_check_in.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class CheckInIndividualScreen extends StatelessWidget {
  static const route = '/check-in-individual';

  const CheckInIndividualScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              title: 'Abdur Rahman',
              subTitle: 'Check In details for the day',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                          time: '8:12',
                          session: 'AM',
                          totalBottomCount: 23,
                          totalTopCount: 23,
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemCount: 2,
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
