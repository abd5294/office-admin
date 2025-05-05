import 'package:flutter/material.dart';
import 'package:office/features/employee/model/employee_timeline_model.dart';
import 'package:office/features/employee/view/widget/leave_timeline_item.dart';

class LeaveTimeline extends StatelessWidget {
  final bool isFestival;

  const LeaveTimeline({super.key, this.isFestival = false});

  @override
  Widget build(BuildContext context) {
    final leaveTimelineModel = EmployeeTimeLineModel().getEmployeeTimeLine();
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
                date: leaveTimelineModel[index].date,
                type: leaveTimelineModel[index].type,
              ),
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemCount: leaveTimelineModel.length,
        ),
      ],
    );
  }
}
