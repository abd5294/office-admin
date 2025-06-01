import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/utils/validators.dart';
import 'package:office/features/auth/controller/auth_state.dart';
import 'package:office/features/update_password/model/update_password.dart';
import 'package:office/features/update_password/repository/update_password_repository.dart';

final updatePasswordControllerProvider =
    StateNotifierProvider<UpdatePasswordController, bool>((ref) {
      return UpdatePasswordController(
        ref.read(updatePasswordRepositoryProvider),
        ref,
      );
    });

class UpdatePasswordController extends StateNotifier<bool> {
  final UpdatePasswordRepository updatePasswordRepository;
  final Ref ref;

  UpdatePasswordController(this.updatePasswordRepository, this.ref)
    : super(false);

  void sendOtp(String email) async {
    try {
      await updatePasswordRepository.sendOtp(email);
    } catch (err) {}
  }

  void updatePassword(UpdatePasswordModel model) async {
    final passwordError = validatePassword(
      model.password,
      model.confirmPassword,
    );
    // if (passwordError != null) state = AuthFailure(passwordError);
    final otpError = validateOtp(model.otp.toString());
    // if (otpError != null) state = AuthFailure(otpError);
  }
}
