import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/auth/model/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<UserModel?> login(String email, String password) async {
    try {
      // final response = await dio.post(
      //   '/users/login',
      //   data: jsonEncode({
      //     'email': 'sathak@thepilot.in',
      //     'password': 'Thepilot\$789',
      //   }),
      final response = await dio.post(
        '/users/login',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.data != null && response.data['data'] != null) {
        final user = UserModel.fromMap(
          response.data['data']['user'],
          response.data['data']['token'],
        );
        return user;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Invalid api response',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
