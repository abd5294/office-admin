import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/features/checkin/controller/check_in_list_controller.dart';
import 'package:office/features/checkin/model/check_in_list_model.dart';
import 'package:office/features/checkin/view/widgets/check_in_card.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class CheckInListScreen extends ConsumerWidget {
  static final route = '/check-in-screen';
  final int id;
  final String name;

  const CheckInListScreen({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkInState = ref.watch(checkInListControllerProvider(id));
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
              title: name,
              subTitle: 'Employee Details',
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
                  checkInState.when(
                    data:
                        (data) => Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder:
                                (context, index) => CheckInCard(
                                  index: index + 1,
                                  date: data[index].date,
                                  id: id,
                                ),
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 12),
                            itemCount: data.length,
                          ),
                        ),
                    error:
                        (error, stackTrace) =>
                            Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator()),
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
