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
    final memos = await repo.getListOfMemosOfTheUser(token: token);

    if (memos.isEmpty) {
      throw 'No Memos Found';
    }

    return memos;
  }

  // You can add create/update/delete methods here as needed
}

/// Admin-only Memo Controller
final adminMemoControllerProvider =
    AsyncNotifierProvider<AdminMemoController, List<Memo>>(
      () => AdminMemoController(),
    );

class AdminMemoController extends AsyncNotifier<List<Memo>> {
  @override
  Future<List<Memo>> build({int? departmentId}) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);

    // Default to -1 if departmentId is not provided (fetch all)
    final memos = await repo.getMemosByDepartmentId(
      token: token,
      departmentId: departmentId ?? -1,
    );
    return memos;
  }

  // Get all memos (Admin)
  Future<List<Memo>> getAllMemos() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);
    final memos = await repo.getAllMemos(token: token);
    if (memos.isEmpty) {
      throw 'No Memos Found';
    }
    return memos;
  }

  // Get memo by ID (Admin)
  Future<Memo> getMemoById(int memoId) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);
    return await repo.getMemoById(token: token, memoId: memoId);
  }

  // Create memo (Admin)
  Future<Memo> createMemo({
    required String title,
    required String description,
    int? departmentId,
  }) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);
    return await repo.createMemo(
      token: token,
      title: title,
      description: description,
      departmentId: departmentId,
    );
  }

  // Update memo (Admin)
  Future<Memo> updateMemo({
    required int memoId,
    required String title,
    required String description,
    int? departmentId,
  }) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);
    return await repo.updateMemo(
      token: token,
      memoId: memoId,
      title: title,
      description: description,
      departmentId: departmentId,
    );
  }

  // Delete memo (Admin)
  Future<void> deleteMemo(int memoId) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(memoRepositoryProvider);
    await repo.deleteMemo(token: token, memoId: memoId);
  }
}
