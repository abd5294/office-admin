import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/employee/models/updated_employee_model.dart';
import 'package:office/shared/models/employee_model.dart';

final manageEmployeeRepositoryProvider = Provider((ref) {
  return ManageEmployeeRepository(dio: ref.read(dioProvider));
});

class ManageEmployeeRepository {
  final Dio dio;

  ManageEmployeeRepository({required this.dio});

  Future<List<EmployeeModel>> getEmployees(String token) async {
    final response = await dio.get(
      '/users',
      options: Options(headers: {'Authorization': token}),
    );

    final employees =
        (response.data['data'] as List)
            .map((el) => EmployeeModel.fromMap(el))
            .toList();

    return employees;
  }

  Future updateUser(String token, UpdateEmployeeModel employee, id) async {
    Map<String, dynamic> employeeMap = employee.toMap();
    Map<String, dynamic> extraMap = {"gender": "male"};
    Map<String, dynamic> mergedMap = {...employeeMap, ...extraMap};

    try {
      await dio.put(
        '/users/$id',
        data: {
          "name": "Abdur Rahman",
          "role": "employee",
          "email": "abdur@example.com",
          "password": "abdur123",
          "designation": "Software Engineer",
          "bloodType": "O",
          "gender": "male",
          "phone": "1234567890",
        },
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
