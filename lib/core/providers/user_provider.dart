import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/features/auth/model/user_model.dart';

final userProvider = StateProvider<UserModel?>(
  (ref) => null,
);
