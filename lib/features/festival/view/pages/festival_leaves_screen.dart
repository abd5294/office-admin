import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/view/widget/leave_timeline.dart';
import 'package:office/features/festival/view/pages/create_festival_screen.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';

class FestivalLeavesScreen extends StatelessWidget {
  static const route = '/festival-leaves';

  const FestivalLeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 30.0,
            ),
            child: SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  context.push(CreateFestivalScreen.route);
                },
                shape: CircleBorder(),
                backgroundColor: Palette.primaryColor,
                child: Icon(Icons.add, color: Colors.white, size: 40),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
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
                  'Festival Leaves,',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Enjoy your holidays!',
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
                    'Timeline of leaves',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),

                  Expanded(child: LeaveTimeline(isFestival: true)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
