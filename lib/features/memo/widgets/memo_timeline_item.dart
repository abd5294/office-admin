import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/features/memo/controller/memo_controller.dart';
import 'package:office/features/memo/model/memo_model.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/format_date.dart';
import 'package:office/core/providers/user_provider.dart';

class MemoTimelineItem extends ConsumerWidget {
  final Memo memo;
  // final VoidCallback onDelete;

  const MemoTimelineItem({
    super.key,
    required this.memo,
    // required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);

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
                if (user != null && user.role == 'admin') ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      context.push('/edit-memo', extra: memo);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        await ref
                            .read(adminMemoControllerProvider.notifier)
                            .deleteMemo(memo.id);
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Memo deleted successfully'),
                          ),
                        );
                        // Refresh the memo list after deletion
                        ref.invalidate(adminMemoControllerProvider);
                      } catch (error) {
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text('Failed to delete memo: $error'),
                          ),
                        );
                      }
                    },
                    // onTap: onDelete,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
