import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/employee/models/employee_details_model.dart';
import 'package:office/features/employee/models/employee_details_model.dart';
import 'package:office/features/employee/models/employee_details_model.dart';
import 'package:office/features/employee/repository/employee_details_repository.dart';
import 'package:office/shared/models/employee_model.dart';

final employeeDetailsControllerProvider =
    AsyncNotifierProvider.family<EmployeeDetailsController, EmployeeDetailsModel, int>(
      EmployeeDetailsController.new,
    );

class EmployeeDetailsController extends FamilyAsyncNotifier<EmployeeDetailsModel, int> {
  late final int id;

  @override
  Future<EmployeeDetailsModel> build(int id) async {
    this.id = id;

    final token = ref.read(userProvider)!.token;
    final repo = ref.read(employeeDetailsRepositoryProvider);
    final employee = await repo.getEmployee(token, id);
    return employee;
  }
}
