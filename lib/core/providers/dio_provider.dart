import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(baseUrl: 'https://king-prawn-app-5g3au.ondigitalocean.app'),
  );
});
