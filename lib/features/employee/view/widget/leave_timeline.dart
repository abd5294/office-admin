import 'package:flutter/material.dart';
import 'package:office/features/employee/view/widget/leave_timeline_item.dart';

class LeaveTimeline extends StatelessWidget {
  final bool isFestival;

  const LeaveTimeline({super.key, this.isFestival = false});

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
          shrinkWrap: true,
          itemBuilder:
              (context, index) => LeaveTimelineItem(
                date: '16th March',
                isFestival: true,
                message: 'Holiday on account of EID',
                note: 'Enjoy your holiday',
              ),
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemCount: 4,
        ),
      ],
    );
  }
}
