import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/memo/controller/memo_controller.dart';
import 'package:office/features/memo/model/department_model.dart';
import 'package:office/features/memo/widgets/memo_time_line_list.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class MemoByDeptScreen extends ConsumerWidget {
  static const route = '/memo-by-dept';

  final Department department;

  const MemoByDeptScreen({super.key, required this.department});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    // Watch the provider to get the AsyncValue state for memos
    final memoState = ref
        .watch(adminMemoControllerProvider.notifier)
        .build(departmentId: department.id);

    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Memos for ${department.name}',
              subTitle: 'View memos for your department',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'List of memos for ${department.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: FutureBuilder(
                      future: memoState,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return MemoTimeLineList(
                            timeLine: snapshot.data ?? [],
                          );
                        } else {
                          return const Center(child: Text('No memos found.'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
