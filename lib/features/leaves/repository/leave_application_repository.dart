import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/leaves/model/create_leave_application_model.dart';
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

  Future updateLeaveApplication(
    String token,
    LeaveApplicationModel model,
  ) async {
    final updatedLeave = jsonEncode(model.toMap());
    try {
      await dio.put(
        '/leaves/${model.id}',
        options: Options(headers: {'Authorization': token}),
        data: updatedLeave,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future createLeaveApplication(
    String token,
    CreateLeaveApplicationModel applicationModel,
  ) async {
    final newApplication = jsonEncode(applicationModel.toMap());
    print(newApplication);
    try {
      await dio.post(
        '/leaves',
        options: Options(headers: {'Authorization': token}),
        data: newApplication,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteLeaveApplication(int id, String token) async {
    try {
      await dio.delete(
        '/leaves/$id',
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
