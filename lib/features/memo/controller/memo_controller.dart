import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/memo/model/memo_model.dart';
import 'package:office/features/memo/repository/memo_repository.dart';

final memoControllerProvider =
    AsyncNotifierProvider<MemoController, List<Memo>>(() => MemoController());

class MemoController extends AsyncNotifier<List<Memo>> {
  @override
  Future<List<Memo>> build() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);
    final memos = await repo.getListOfMemosOfTheUser(token);

    if (memos.isEmpty) {
      throw 'No Memos Found';
    }

    return memos;
  }

  // You can add create/update/delete methods here as needed
}
