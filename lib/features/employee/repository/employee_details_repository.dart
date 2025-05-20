import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/shared/models/employee.dart';

final employeeDetailsRepositoryProvider = Provider((ref) {
  return EmployeeDetailsRepository(dio: ref.read(dioProvider));
});

class EmployeeDetailsRepository {
  final Dio dio;

  EmployeeDetailsRepository({required this.dio});

  Future<Employee> getEmployee(String token, int id) async {
    final response = await dio.get(
      '/users/$id',
      options: Options(headers: {'Authorization': token}),
    );
    final employee = Employee.fromMap(response.data['data']);
    return employee;
  }
}
