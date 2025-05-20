import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/repository/employee_repository.dart';
import 'package:office/shared/models/employee.dart';

final employeeControllerProvider =
    AsyncNotifierProvider<EmployeeController, List<Employee>>(() {
      return EmployeeController();
    });

class EmployeeController extends AsyncNotifier<List<Employee>> {
  @override
  Future<List<Employee>> build() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(employeeRepositoryProvider);
    final employees = await repo.getEmployees(token);
    if (employees.isEmpty) throw Exception("No employees found");
    return employees;
  }
}
