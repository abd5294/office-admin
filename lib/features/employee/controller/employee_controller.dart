import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/repository/employee_repository.dart';
import 'package:office/shared/models/employee_model.dart';

final employeeControllerProvider =
    AsyncNotifierProvider<EmployeeController, List<EmployeeModel>>(() {
      return EmployeeController();
    });

class EmployeeController extends AsyncNotifier<List<EmployeeModel>> {
  @override
  Future<List<EmployeeModel>> build() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(employeeRepositoryProvider);
    final employees = await repo.getEmployees(token);
    if (employees.isEmpty) throw Exception("No employees found");
    final filteredEmployees =
        employees
            .where((employee) => employee.role.toLowerCase() != 'admin')
            .toList();

    return filteredEmployees;
  }
}
