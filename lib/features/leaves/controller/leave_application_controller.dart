import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/leaves/model/leave_application_model.dart';
import 'package:office/features/leaves/repository/leave_application_repository.dart';

final leaveApplicationControllerProvider = AsyncNotifierProvider<
  LeaveApplicationController,
  List<LeaveApplicationModel>
>(() {
  return LeaveApplicationController();
});

class LeaveApplicationController
    extends AsyncNotifier<List<LeaveApplicationModel>> {
  @override
  Future<List<LeaveApplicationModel>> build() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(leaveApplicationRepositoryProvider);
    final applications = await repo.getLeaveApplications(token);

    if (applications.isEmpty) throw 'No Leave Applications Found';

    final filteredApplications =
        applications
            .where(
              (application) => application.choice.toLowerCase() == 'undecided',
            )
            .toList();

    return filteredApplications;
  }
}
