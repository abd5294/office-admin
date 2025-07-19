import 'package:flutter/material.dart';
import 'package:office/features/memo/controller/memo_controller.dart';
import 'package:office/features/memo/model/memo_model.dart';
import 'package:office/features/memo/widgets/memo_timeline_item.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemoTimeLineList extends ConsumerWidget {
  final List<Memo> timeLine;

  const MemoTimeLineList({super.key, required this.timeLine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            return MemoTimelineItem(
              memo: memo,
              onDelete: () async {
                await ref
                    .read(adminMemoControllerProvider.notifier)
                    .deleteMemo(memo.id);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: timeLine.length,
        ),
      ],
    );
  }
}
