import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/repository/check_in_out_repository.dart';

final checkInOutControllerProvider =
    StateNotifierProvider.family<CheckInNotifier, bool, String?>(
      (ref, imagePath) => CheckInNotifier(ref, imagePath),
    );

class CheckInNotifier extends StateNotifier<bool> {
  final Ref ref;
  final String? imagePath;

  CheckInNotifier(this.ref, this.imagePath) : super(false);

  Future<void> createCheckIn() async {
    state = true;
    try {
      final token = ref.read(userProvider)!.token;
      final repo = ref.read(checkInOutRepositoryProvider);
      await repo.createCheckIn(imagePath, token);
    } finally {
      state = false;
    }
  }
}
