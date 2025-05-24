import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';

final festivalLeaveRepositoryProvider = Provider((ref) {
  return FestivalLeaveRepository(dio: ref.read(dioProvider));
});

class FestivalLeaveRepository {
  final Dio dio;

  FestivalLeaveRepository({required this.dio});

  // GET
  Future<List<FestivalLeaveModel>> getFestivalLeaves(String token) async {
    final response = await dio.get(
      '/holiday',
      options: Options(headers: {'Authorization': token}),
    );

    final festivalLeaves = (response.data['data'] as List)
        .map((el) => FestivalLeaveModel.fromMap(el))
        .toList();

    return festivalLeaves;
  }

  // CREATE
  Future<void> createFestivalLeave(String token, FestivalLeaveModel newLeave) async {
    final leaveMap = jsonEncode(newLeave.toMap());
    print(leaveMap);
    try {
      await dio.post(
        '/holiday',
        data: leaveMap,
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      print('Create Festival Leave Error: ${e.toString()}');
    }
  }

  // UPDATE
  Future<void> updateFestivalLeave(String token, FestivalLeaveModel leave, String id) async {
    final leaveMap = jsonEncode(leave.toMap());

    try {
      await dio.put(
        '/holiday/$id',
        data: leaveMap,
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      print('Update Festival Leave Error: ${e.toString()}');
    }
  }
}
