import 'package:flutter/material.dart';
import 'package:office/features/employee/models/leave_details_model.dart';
import 'package:office/features/employee/view/widget/leave_timeline_item.dart';

class LeaveTimeLineList extends StatelessWidget {
  final bool isFestival;
  final List<LeaveDetailsModel> timeLine;

  const LeaveTimeLineList({
    super.key,
    this.isFestival = false,
    required this.timeLine,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 17,
          child: Container(
            width: 1,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
          ),
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder:
              (context, index) => LeaveTimelineItem(
                date: timeLine[index].date,
                type: timeLine[index].type,
                isFestival: isFestival,
              ),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: timeLine.length,
        ),
      ],
    );
  }
}
