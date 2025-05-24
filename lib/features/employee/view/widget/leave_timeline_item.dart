import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';
import 'package:office/features/festival/view/pages/edit_festival_screen.dart';

class LeaveTimelineItem extends StatelessWidget {
  final String date;
  final String type;
  final bool isFestival;
  final String occasion;
  final String note;
  final int? id;

  const LeaveTimelineItem({
    super.key,
    required this.date,
    this.isFestival = false,
    this.type = '',
    this.occasion = '',
    this.note = '',
    this.id,
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
                      : type == 'approved'
                      ? Colors.green
                      : type == 'Half leave'
                      ? Colors.yellowAccent
                      : Colors.red,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
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
                            const SizedBox(height: 4),
                            Text(
                              'Holiday on account of $occasion',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            final festival = FestivalLeaveModel(
                              id: id,
                              date: date,
                              occasion: occasion,
                              type: type,
                            );
                            context.push(
                              EditFestivalScreen.route,
                              extra: festival,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(4),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                    : type == 'unapproved_holiday'
                    ? Text('Unapproved leave on $date')
                    : Text('Approved leave on $date'),
          ),
        ],
      ),
    );
  }
}
