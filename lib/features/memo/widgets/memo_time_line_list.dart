import 'package:flutter/material.dart';
import 'package:office/features/memo/model/memo_model.dart';
import 'package:office/features/memo/widgets/memo_timeline_item.dart';

class MemoTimeLineList extends StatelessWidget {
  final List<Memo> timeLine;

  const MemoTimeLineList({super.key, required this.timeLine});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 25,
          child: Container(
            width: 1,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final memo = timeLine[index];
            return MemoTimelineItem(memo: memo);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: timeLine.length,
        ),
      ],
    );
  }
}
