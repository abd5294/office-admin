import 'package:flutter/material.dart';
import 'package:office/features/employee/view/widget/leave_timeline_item.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';

class FestivalTimeLineList extends StatelessWidget {
  final bool isFestival;
  final List<FestivalLeaveModel> timeLine;

  const FestivalTimeLineList({
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
          shrinkWrap: true,
          itemBuilder:
              (context, index) => LeaveTimelineItem(
                date: timeLine[index].date,
                isFestival: isFestival,
                occasion: timeLine[index].occasion,
                id: timeLine[index].id,
                type: timeLine[index].type,
              ),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: timeLine.length,
        ),
      ],
    );
  }
}
