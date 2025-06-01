import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/auth/controller/auth_state.dart';
import 'package:office/features/auth/repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref.read(authRepositoryProvider), ref);
  },
);

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final Ref ref;

  AuthController(this.authRepository, this.ref) : super(AuthInitial());

  void userLogin(String email, String password) async {
    state = AuthLoading();
    try {
      final user = await authRepository.login(email, password);
      if (user != null) {
        state = AuthSuccess();
        ref.read(userProvider.notifier).state = user;
      } else {
        state = AuthFailure('Login Failed');
      }
    } catch (e) {
      state = AuthFailure('Login Failed');
    }
  }

  void sendOtp(String email) async {
    try {
      await authRepository.sendOtp(email);
    } catch (err) {
      state = AuthFailure('Failed...');
    }
  }
}
