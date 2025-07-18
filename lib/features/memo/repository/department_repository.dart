import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/memo/model/department_model.dart';

final departmentRepositoryProvider = Provider((ref) {
  return DepartmentRepository(dio: ref.read(dioProvider));
});

class DepartmentRepository {
  final Dio dio;

  DepartmentRepository({required this.dio});

  Future<List<Department>> getListOfDepartments(String token) async {
    final response = await dio.get(
      '/departments/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final departments =
        (response.data['data'] as List)
            .map((el) => Department.fromMap(el))
            .toList();
    return departments;
  }

  Future<Department> getDepartmentById(String token, int id) async {
    final response = await dio.get(
      '/departments/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return Department.fromMap(response.data['data']);
  }

  Future<Department> createDepartment(
    String token,
    Department department,
  ) async {
    final response = await dio.post(
      '/departments/',
      data: department.toMap(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return Department.fromMap(response.data['data']);
  }

  Future<Department> updateDepartment(
    String token,
    int id,
    Department department,
  ) async {
    final response = await dio.put(
      '/departments/$id',
      data: department.toMap(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return Department.fromMap(response.data['data']);
  }

  Future<void> deleteDepartment(String token, int id) async {
    await dio.delete(
      '/departments/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
