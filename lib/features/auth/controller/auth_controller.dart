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

  void userLogin() async {
    state = AuthLoading();

    final user = await authRepository.login();
    if (user != null) {
      ref.read(userProvider.notifier).state = user;
      state = AuthSuccess();
      print(user.name);
    } else {
      state = AuthFailure('Something went wrong');
    }
  }
}
