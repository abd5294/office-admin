import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/auth/model/user_model.dart';
import 'package:office/shared/models/employee.dart';

final employeeRepositoryProvider = Provider((ref) {
  return EmployeeRepository(dio: ref.read(dioProvider));
});

class EmployeeRepository {
  final Dio dio;

  EmployeeRepository({required this.dio});

  Future<List<Employee>> getEmployees(String token) async {
    final response = await dio.get(
      'https://king-prawn-app-5g3au.ondigitalocean.app/users',
      options: Options(headers: {'Authorization': token}),
    );
    final employee =
        (response.data['data'] as List)
            .map((el) => Employee.fromMap(el))
            .toList();

    return employee;
  }
}
