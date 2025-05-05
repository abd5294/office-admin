import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class LeaveTimelineItem extends StatelessWidget {
  final String date;
  final String type;
  final bool isFestival;
  final String message;
  final String note;

  const LeaveTimelineItem({
    super.key,
    required this.date,
    this.isFestival = false,
    this.type = '',
    this.message = '',
    this.note = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  isFestival
                      ? Colors.green
                      : type == 'Approved'
                      ? Colors.green
                      : type == 'Half leave'
                      ? Colors.yellowAccent
                      : Colors.red,
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(12),
            child:
                isFestival
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              message,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Note: $note',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    )
                    : Text('$type leave on $date'),
          ),
        ],
      ),
    );
  }
}
