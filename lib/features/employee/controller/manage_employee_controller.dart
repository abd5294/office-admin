import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/controller/employee_details_controller.dart';
import 'package:office/features/employee/models/create_employee_model.dart';
import 'package:office/features/employee/models/updated_employee_model.dart';
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
        employees.where((e) => e.role.toLowerCase() != 'admin').toList();
    return filteredEmployees;
  }

  Future<void> updateEmployee(
    UpdateEmployeeModel updatedEmployee,
    int id,
  ) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(manageEmployeeRepositoryProvider);

    await repo.updateEmployee(token, updatedEmployee, id);

    state = const AsyncLoading();
    final employees = await repo.getEmployees(token);
    final filteredEmployees =
        employees.where((e) => e.role.toLowerCase() != 'admin').toList();
    state = AsyncData(filteredEmployees);
  }

  Future<void> createEmployee(CreateEmployeeModel newEmployee) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(manageEmployeeRepositoryProvider);

    await repo.createEmployee(token, newEmployee);

    state = const AsyncLoading();

    final employees = await repo.getEmployees(token);

    final filteredEmployees =
        employees.where((e) => e.role.toLowerCase() != 'admin').toList();

    state = AsyncData(filteredEmployees);
  }
}
