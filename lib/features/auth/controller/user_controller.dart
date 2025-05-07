import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/features/auth/model/user_model.dart';

final userProvider = StateProvider<UserModel>(
  (ref) => UserModel(id: '123', name: 'Abdur', email: 'abdur', role: 'admin'),
);
