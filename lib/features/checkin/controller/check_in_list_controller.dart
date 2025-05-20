import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/model/check_in_list_model.dart';
import 'package:office/features/checkin/repository/check_in_list_repository.dart';

final checkInListControllerProvider = AsyncNotifierProvider.family<
  CheckInListController,
  List<CheckInListModel>,
  int
>(CheckInListController.new);

class CheckInListController
    extends FamilyAsyncNotifier<List<CheckInListModel>, int> {
  late final int id;

  @override
  Future<List<CheckInListModel>> build(int id) async {
    this.id = id;
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(checkInRepositoryProvider);
    final checkInsRaw = await repo.getCheckInDetails(id, token);

    if (checkInsRaw.isEmpty) throw Exception("No check-ins found");
    final checkIns = checkInsRaw.map((e) {
      final formatString =  e.date.substring(0, 10);
      return CheckInListModel(formatString);
    },).toList();
    return checkIns;
  }
}
