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

  Future<List<Memo>> getListOfMemosOfTheUser(String token) async {
    final response = await dio.get(
      '/memos/individual/user',
      options: Options(headers: {'Authorization': token}),
    );

    final memos =
        (response.data['data'] as List).map((el) => Memo.fromMap(el)).toList();
    return memos;
  }
}
