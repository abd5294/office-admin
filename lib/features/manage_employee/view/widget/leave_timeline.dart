import 'package:flutter/material.dart';
import 'package:office/features/manage_employee/view/widget/leave_timeline_item.dart';

class LeaveTimeline extends StatelessWidget {
  const LeaveTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 17,
          child: Container(
            width: 2,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder:
              (context, index) => LeaveTimelineItem(date: '16th March'),
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemCount: 4,
        ),
      ],
    );
  }
}
