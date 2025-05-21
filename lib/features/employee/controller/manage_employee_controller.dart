import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/repository/manage_employees_repository.dart';
import 'package:office/shared/models/employee_model.dart';

final manageEmployeeControllerProvider =
AsyncNotifierProvider<ManageEmployeeController, List<EmployeeModel>>(() {
  return ManageEmployeeController();
});

class ManageEmployeeController extends AsyncNotifier<List<EmployeeModel>> {
  @override
  Future<List<EmployeeModel>> build() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(manageEmployeeRepositoryProvider);
    final employees = await repo.getEmployees(token);
    if (employees.isEmpty) throw Exception("No employees found");
    final filteredEmployees =
    employees
        .where((employee) => employee.role.toLowerCase() != 'admin')
        .toList();
    return filteredEmployees;
  }
}
