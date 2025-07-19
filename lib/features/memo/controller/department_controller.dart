import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/memo/model/department_model.dart';
import 'package:office/features/memo/repository/department_repository.dart';

final departmentControllerProvider =
    AsyncNotifierProvider<DepartmentController, List<Department>>(
      () => DepartmentController(),
    );

class DepartmentController extends AsyncNotifier<List<Department>> {
  late final DepartmentRepository _repo;
  late final String _token;

  @override
  Future<List<Department>> build() async {
    _token = ref.read(userProvider)!.token;
    _repo = ref.read(departmentRepositoryProvider);
    List<Department> departments = await _repo.getListOfDepartments(_token);
    departments = [
      Department(id: -1, name: 'All', description: ""),
      ...departments,
    ];
    if (departments.isEmpty) {
      throw 'No Departments Found';
    }

    return departments;
  }

  Future<void> createDepartment(Department department) async {
    await _repo.createDepartment(_token, department);
    state = const AsyncLoading();
    state = AsyncValue.data(await _repo.getListOfDepartments(_token));
  }

  Future<void> updateDepartment(int id, Department department) async {
    await _repo.updateDepartment(_token, id, department);
    state = const AsyncLoading();
    state = AsyncValue.data(await _repo.getListOfDepartments(_token));
  }

  Future<void> deleteDepartment(int id) async {
    await _repo.deleteDepartment(_token, id);
    state = const AsyncLoading();
    state = AsyncValue.data(await _repo.getListOfDepartments(_token));
  }
}
