import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/repository/employee_details_repository.dart';
import 'package:office/shared/models/employee.dart';

final employeeDetailsControllerProvider =
    AsyncNotifierProvider.family<EmployeeDetailsController, Employee, int>(
      EmployeeDetailsController.new,
    );

class EmployeeDetailsController extends FamilyAsyncNotifier<Employee, int> {
  late final int id;

  @override
  Future<Employee> build(int id) async {
    this.id = id;

    final token = ref.read(userProvider)!.token;
    final repo = ref.read(employeeDetailsRepositoryProvider);
    final employee = await repo.getEmployee(token, id);
    return employee;
  }
}
