import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/employee/models/employee_details_model.dart';
import 'package:office/shared/models/employee_model.dart';

final employeeDetailsRepositoryProvider = Provider((ref) {
  return EmployeeDetailsRepository(dio: ref.read(dioProvider));
});

class EmployeeDetailsRepository {
  final Dio dio;

  EmployeeDetailsRepository({required this.dio});

  Future<EmployeeDetailsModel> getEmployee(String token, int id) async {
    try {
      final response = await dio.get(
        '/app/$id',
        options: Options(headers: {'Authorization': token}),
      );
      final employee = EmployeeDetailsModel.fromMap(response.data['data']);
      return employee;
    } catch (e) {
      rethrow;
    }
  }
}
