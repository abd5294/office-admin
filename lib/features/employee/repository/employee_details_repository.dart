import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/models/employee_details_model.dart';

final employeeDetailsRepositoryProvider = Provider((ref) {
  return EmployeeDetailsRepository(
    dio: ref.read(dioProvider),
    role: ref.read(userProvider)!.role,
  );
});

class EmployeeDetailsRepository {
  final Dio dio;
  final String role;

  EmployeeDetailsRepository({required this.dio, required this.role});

  Future<EmployeeDetailsModel> getEmployee(String token, int id) async {
    try {
      Response response;

      if (role == 'admin') {
        response = await dio.get(
          '/app/$id',
          options: Options(headers: {'Authorization': token}),
        );
      } else {
        response = await dio.get(
          '/app',
          options: Options(headers: {'Authorization': token}),
        );
      }

      final employee = EmployeeDetailsModel.fromMap(response.data['data']);
      return employee;
    } catch (e) {
      rethrow;
    }
  }
}
