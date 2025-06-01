import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';

final updatePasswordRepositoryProvider = Provider<UpdatePasswordRepository>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return UpdatePasswordRepository(dio);
});

class UpdatePasswordRepository {
  final Dio dio;
  UpdatePasswordRepository(this.dio);

  Future<void> sendOtp(String email) async {
    try {
      await dio.post(
        '/users/forget-password',
        data: jsonEncode({'email': email}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } catch (err) {
      throw 'Login Error $err';
    }
  }

  Future updatePassword() async {}
}
