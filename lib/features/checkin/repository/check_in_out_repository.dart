import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:office/core/providers/dio_provider.dart';

final checkInOutRepositoryProvider = Provider((ref) {
  return CheckInOutRepository(dio: ref.read(dioProvider));
});

class CheckInOutRepository {
  final Dio dio;

  CheckInOutRepository({required this.dio});

  Future createCheckIn(String? imagePath, String token, String type) async {
    final formData = FormData.fromMap({
      'type': type,
      'image': await MultipartFile.fromFile(
        imagePath!,
        filename: 'abd.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    });
    try {
      await dio.post(
        '/checks',
        data: formData,
        options: Options(headers: {'Authorization': token}),
      );
    } catch (e) {
      rethrow;
    }
  }
}
