import 'package:flutter/material.dart';
import 'package:office/features/memo/model/memo_model.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/format_date.dart';

class MemoTimelineItem extends StatelessWidget {
  final Memo memo;

  const MemoTimelineItem({super.key, required this.memo});

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
              child: Text(memo.title.isNotEmpty ? memo.title[0] : ''),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memo.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      if (memo.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          memo.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],

                      const SizedBox(height: 12),
                      Text(
                        formatCustomDate(memo.createdAt),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      if (memo.department != null) ...[
                        Text(
                          'Department: ${memo.department!.name}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
