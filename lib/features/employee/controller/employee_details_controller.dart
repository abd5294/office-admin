import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/repository/employee_details_repository.dart';
import 'package:office/shared/models/employee_model.dart';

final employeeDetailsControllerProvider =
    AsyncNotifierProvider.family<EmployeeDetailsController, EmployeeModel, int>(
      EmployeeDetailsController.new,
    );

class EmployeeDetailsController extends FamilyAsyncNotifier<EmployeeModel, int> {
  late final int id;

  @override
  Future<EmployeeModel> build(int id) async {
    this.id = id;

    final token = ref.read(userProvider)!.token;
    final repo = ref.read(employeeDetailsRepositoryProvider);
    final employee = await repo.getEmployee(token, id);
    return employee;
  }
}
