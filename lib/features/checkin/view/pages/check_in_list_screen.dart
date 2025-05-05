import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/checkin/controller/check_in_list_controller.dart';
import 'package:office/features/checkin/model/check_in_list_model.dart';
import 'package:office/features/checkin/view/widgets/check_in_card.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';

class CheckInListScreen extends StatelessWidget {
  static final route = '/check-in-page';

  const CheckInListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CheckInListModel> checkInList =
        CheckInListController().getCheckInList();
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(0, 60),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36),
                Text(
                  'Abdur Rahman',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'CheckIn details',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Palette.appGrey),
                ),
              ],
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => CheckInCard(
                          index: index + 1,
                          date: checkInList[index].date,
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemCount: checkInList.length,
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
