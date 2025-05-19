import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/auth/controller/auth_controller.dart';
import 'package:office/features/auth/model/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<UserModel?> login() async {
    try {
      final response = await dio.post(
        'https://king-prawn-app-5g3au.ondigitalocean.app/users/login',
        data: jsonEncode({
          'email': 'johndoe@example.com',
          'password': 'helloworld123',
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final user = UserModel.fromMap(response.data['data']['user']);
      return user;
    } catch (e) {
      throw Exception('Login Error $e');
    }
  }
}
