import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/memo/model/memo_model.dart';

final memoRepositoryProvider = Provider((ref) {
  return MemoRepository(dio: ref.read(dioProvider));
});

class MemoRepository {
  final Dio dio;

  MemoRepository({required this.dio});

  // Get all memos (Admin)
  Future<List<Memo>> getAllMemos({required String token}) async {
    final response = await dio.get(
      '/memos/',
      options: Options(headers: {'Authorization': token}),
    );
    final memos =
        (response.data['data'] as List).map((el) => Memo.fromMap(el)).toList();
    return memos;
  }

  // Get memos available for the user (User)
  Future<List<Memo>> getListOfMemosOfTheUser({required String token}) async {
    final response = await dio.get(
      '/memos/individual/user',
      options: Options(headers: {'Authorization': token}),
    );
    final memos =
        (response.data['data'] as List).map((el) => Memo.fromMap(el)).toList();
    return memos;
  }

  // Get memo by ID (Admin)
  Future<Memo> getMemoById({required String token, required int memoId}) async {
    final response = await dio.get(
      '/memos/$memoId',
      options: Options(headers: {'Authorization': token}),
    );
    return Memo.fromMap(response.data['data']);
  }

  // Get memos by department ID (Admin)
  Future<List<Memo>> getMemosByDepartmentId({
    required String token,
    required int departmentId,
  }) async {
    print(departmentId);
    final val = departmentId == -1 ? "null" : departmentId.toString();

    final response = await dio.get(
      '/memos/department/$val',
      options: Options(headers: {'Authorization': token}),
    );
    final data = response.data['data'];
    if (data is List) {
      return data.map((el) => Memo.fromMap(el)).toList();
    } else if (data is Map) {
      // If API returns a single memo object
      return [Memo.fromMap(data as Map<String, dynamic>)];
    }
    return [];
  }

  // Create memo (Admin)
  Future<Memo> createMemo({
    required String token,
    required String title,
    required String description,
    int? departmentId,
  }) async {
    final body = {
      'title': title,
      'description': description,
      if (departmentId != null) 'department_id': departmentId,
    };
    final response = await dio.post(
      '/memos/',
      data: jsonEncode(body),
      options: Options(
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      ),
    );
    return Memo.fromMap(response.data['data']);
  }

  // Update memo (Admin)
  Future<Memo> updateMemo({
    required String token,
    required int memoId,
    required String title,
    required String description,
    int? departmentId,
  }) async {
    final body = {
      'title': title,
      'description': description,
      if (departmentId != null) 'department_id': departmentId,
    };
    final response = await dio.put(
      '/memos/$memoId',
      data: jsonEncode(body),
      options: Options(
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      ),
    );
    return Memo.fromMap(response.data['data']);
  }

  // Delete memo (Admin)
  Future<void> deleteMemo({required String token, required int memoId}) async {
    await dio.delete(
      '/memos/$memoId',
      options: Options(headers: {'Authorization': token}),
    );
  }
}
