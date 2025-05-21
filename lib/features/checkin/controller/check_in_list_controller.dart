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
    final repo = ref.read(checkInListRepositoryProvider);
    final checkInsRaw = await repo.getCheckInDetails(id, token);

    if (checkInsRaw.isEmpty) throw Exception("No check-ins found");
    final checkIns =
        checkInsRaw.map((e) {
          final dateString = e.date.substring(0, 10);
          DateTime date = DateTime.parse(dateString);
          String formattedDate = '${date.day}/${date.month}/${date.year}';
          return CheckInListModel(formattedDate);
        }).toList();

    final seenDates = <String>{};

    final formattedCheckIn =
        checkIns
            .where((e) {
              if (seenDates.contains(e.date)) {
                return false;
              } else {
                seenDates.add(e.date);
                return true;
              }
            })
            .map((e) {
              return e;
            })
            .toList();

    return formattedCheckIn;
  }
}
