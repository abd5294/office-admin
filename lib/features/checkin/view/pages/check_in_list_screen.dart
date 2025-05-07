import 'package:flutter/material.dart';
import 'package:office/features/checkin/controller/check_in_list_controller.dart';
import 'package:office/features/checkin/model/check_in_list_model.dart';
import 'package:office/features/checkin/view/widgets/check_in_card.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class CheckInListScreen extends StatelessWidget {
  static final route = '/check-in-screen';

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
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Abdur Rahman',
              subTitle: 'Check In Details',
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
                        (context, index) => CheckInCard(
                          index: index + 1,
                          date: checkInList[index].date,
                        ),
                    separatorBuilder: (context, index) =>const SizedBox(height: 12),
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
