import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';
import 'package:office/features/festival/repository/festival_leave_repository.dart';

final festivalLeaveControllerProvider =
    AsyncNotifierProvider<FestivalLeaveController, List<FestivalLeaveModel>>(
      () {
        return FestivalLeaveController();
      },
    );

class FestivalLeaveController extends AsyncNotifier<List<FestivalLeaveModel>> {
  @override
  Future<List<FestivalLeaveModel>> build() async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(festivalLeaveRepositoryProvider);
    final festivalLeaves = await repo.getFestivalLeaves(token);

    if (festivalLeaves.isEmpty) {
      throw 'No Festival Leaves Found';
    }

    return festivalLeaves;
  }

  // CREATE
  Future<void> createFestivalLeave(FestivalLeaveModel leave) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(festivalLeaveRepositoryProvider);

    await repo.createFestivalLeave(token, leave);

    // Refresh the list after creation
    final updatedLeaves = await repo.getFestivalLeaves(token);
    state = AsyncValue.data(updatedLeaves);
  }

  // UPDATE
  Future<void> updateFestivalLeave(String id, FestivalLeaveModel updatedLeave) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(festivalLeaveRepositoryProvider);

    await repo.updateFestivalLeave(token, updatedLeave, id);

    // Refresh the list after update
    final updatedLeaves = await repo.getFestivalLeaves(token);
    state = AsyncValue.data(updatedLeaves);
  }
}