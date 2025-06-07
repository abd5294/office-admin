import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/controller/check_in_out_state.dart';
import 'package:office/features/checkin/repository/check_in_out_repository.dart';

final checkInOutControllerProvider =
    StateNotifierProvider.family<CheckInNotifier, CheckInOutState, String?>(
      (ref, imagePath) => CheckInNotifier(ref, imagePath),
    );

class CheckInNotifier extends StateNotifier<CheckInOutState> {
  final Ref ref;
  final String? imagePath;

  CheckInNotifier(this.ref, this.imagePath) : super(CheckInOutInitial());

  Future<void> createCheckIn(String type) async {
    try {
      final token = ref.read(userProvider)!.token;
      final repo = ref.read(checkInOutRepositoryProvider);

      state = CheckInOutLoading();
      await repo.createCheckIn(imagePath, token, type);

      state = CheckInOutSuccess();
    } on DioException catch (e) {
      final errorMsg = e.response?.data.toString() ?? 'Network error';
      state = CheckInOutFailure(errorMessage: errorMsg);
    } catch (e) {
      state = CheckInOutFailure(errorMessage: e.toString());
    }
  }
}
