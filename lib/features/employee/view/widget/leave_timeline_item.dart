import 'package:flutter/material.dart';

class LeaveTimelineItem extends StatelessWidget {
  final String date;

  const LeaveTimelineItem({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CircleAvatar(radius: 10, backgroundColor: Colors.green),
          ),
          SizedBox(width: 12),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(12),
            child: Text('Approved leave on $date'),
          ),
        ],
      ),
    );
  }
}
