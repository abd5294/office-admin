import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
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

    final employees = (response.data['data'] as List)
        .map((el) => EmployeeModel.fromMap(el))
        .toList();

    return employees;
  }
}
