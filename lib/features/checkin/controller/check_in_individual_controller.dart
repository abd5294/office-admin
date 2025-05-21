import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/model/check_in_individual_model.dart';
import 'package:office/features/checkin/repository/check_in_individual_repository.dart';

final checkInIndividualControllerProvider = AsyncNotifierProvider.family<
  CheckInIndividualController,
  List<CheckInIndividualModel>,
  int
>(CheckInIndividualController.new);

class CheckInIndividualController
    extends FamilyAsyncNotifier<List<CheckInIndividualModel>, int> {
  @override
  Future<List<CheckInIndividualModel>> build(int id) async {
    final repo = ref.read(checkInIndividualRepositoryProvider);
    final token = ref.read(userProvider)!.token;

    List<CheckInIndividualModel> resultRaw = await repo.getCheckInDetails(
      id,
      token,
    );

    final modelResult =
        resultRaw.map((e) {
          final hoursTime = e.time.substring(11, 16);
          return CheckInIndividualModel(e.name, hoursTime);
        }).toList();

    final result = modelResult.sublist(0, 1);

    return result;
  }
}
