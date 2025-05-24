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

    final updatedLeaves = await repo.getFestivalLeaves(token);
    state = AsyncValue.data(updatedLeaves);
  }

  // UPDATE
  Future<void> updateFestivalLeave(FestivalLeaveModel updatedLeave) async {
    final token = ref.read(userProvider)!.token;
    final repo = ref.read(festivalLeaveRepositoryProvider);

    await repo.updateFestivalLeave(token, updatedLeave);

    final updatedLeaves = await repo.getFestivalLeaves(token);
    state = AsyncValue.data(updatedLeaves);
  }
}