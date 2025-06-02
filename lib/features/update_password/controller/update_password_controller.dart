import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/features/update_password/controller/update_password_state.dart';
import 'package:office/features/update_password/model/update_password_model.dart';
import 'package:office/features/update_password/repository/update_password_repository.dart';

final updatePasswordControllerProvider =
    StateNotifierProvider<UpdatePasswordController, UpdatePasswordState>((ref) {
      return UpdatePasswordController(
        ref.read(updatePasswordRepositoryProvider),
        ref,
      );
    });

class UpdatePasswordController extends StateNotifier<UpdatePasswordState> {
  final UpdatePasswordRepository updatePasswordRepository;
  final Ref ref;

  UpdatePasswordController(this.updatePasswordRepository, this.ref)
    : super(UpdatePasswordState());

  void sendOtp(String email) async {
    try {
      state = UpdatePasswordState(status: UpdateStatus.loading);
      await updatePasswordRepository.sendOtp(email);
      state = UpdatePasswordState(
        status: UpdateStatus.success,
        step: UpdateStep.emailSent,
      );
    } on DioException catch (err) {
      state = UpdatePasswordState(
        status: UpdateStatus.error,
        message: err.response!.data['error'],
      );
    } catch (err) {
      state = UpdatePasswordState(
        status: UpdateStatus.error,
        message: 'An error occurred',
      );
    }
  }

  void updatePassword(UpdatePasswordModel model) async {
    try {
      state = state.copyWith(status: UpdateStatus.loading);
      await updatePasswordRepository.updatePassword(model);
      state = UpdatePasswordState(
        status: UpdateStatus.success,
        step: UpdateStep.passwordUpdated,
      );
    } on DioException catch (err) {
      state = UpdatePasswordState(
        status: UpdateStatus.error,
        message: err.response!.data['error'],
      );
    } catch (err) {
      state = state.copyWith(
        status: UpdateStatus.error,
        message: 'Failed to update password. Please try again.',
      );
    }
  }
}
