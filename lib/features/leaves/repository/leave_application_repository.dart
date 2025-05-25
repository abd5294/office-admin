import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/leaves/model/leave_application_model.dart';

final leaveApplicationRepositoryProvider = Provider((ref) {
  return LeaveApplicationRepository(dio: ref.read(dioProvider));
});

class LeaveApplicationRepository {
  final Dio dio;

  LeaveApplicationRepository({required this.dio});

  Future<List<LeaveApplicationModel>> getLeaveApplications(String token) async {
    final response = await dio.get(
      '/leaves',
      options: Options(headers: {'Authorization': token}),
    );
    final leaves =
        (response.data['data'] as List).map((el) {
          final user = el['user']['name'];
          return LeaveApplicationModel.fromMap({...el, 'name': user});
        }).toList();

    return leaves;
  }

  Future updateLeaveApplication(String token, int id, String choice) async {
    final updatedLeave = jsonEncode({"choice": choice});
    try {
      await dio.put(
        '/leaves/$id',
        options: Options(headers: {'Authorization': token}),
        data: updatedLeave,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
