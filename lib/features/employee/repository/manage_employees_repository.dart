import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/employee/models/create_employee_model.dart';
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

  // Update
  Future updateEmployee(String token, UpdateEmployeeModel employee, id) async {
    final employeeMap = jsonEncode(employee.toMap());
    print(employeeMap);
    try {
      await dio.put(
        '/users/$id',
        data: employeeMap,
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Create
  Future createEmployee(String token, CreateEmployeeModel newEmployee) async {
    final employeeMap = jsonEncode(newEmployee.toMap());
    try {
      print(employeeMap);
      await dio.post(
        '/users',
        data: employeeMap,
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
