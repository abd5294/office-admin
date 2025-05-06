import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/leaves/view/widgets/leave_application_tile.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class LeaveApplicationScreen extends StatelessWidget {
  static final route = '/leave';

  const LeaveApplicationScreen({super.key});

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
              title: 'Leave Application',
              subTitle: 'Provide leave for your employees',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leave Application List',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:
                          (context, index) => LeaveApplicationTile(
                            name: 'Abdur Rahman',
                            dateOfLeave: '12/12/2025',
                            reason: 'lorem ipsum',
                            remainingLeave: '21',
                            totalApprovedLeaves: '4',
                            totalUnApprovedLeaves: '3',
                            typeOfLeave: 'Casual',
                            index: index + 1,
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 12),
                      itemCount: 2,
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
