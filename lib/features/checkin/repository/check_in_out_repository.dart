import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';

final checkInOutRepositoryProvider = Provider((ref) {
  return CheckInOutRepository(dio: ref.read(dioProvider));
});

class CheckInOutRepository {
  final Dio dio;

  CheckInOutRepository({required this.dio});

  Future createCheckIn(String? imagePath, String token) async {
    final formData = FormData.fromMap({
      'type': 'checkin',
      'image': await MultipartFile.fromFile(
        imagePath!,
        filename:
            'Checkin_time${DateTime.now().millisecondsSinceEpoch.toString()}',
      ),
    });
    await dio.post(
      '/checks',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {'Authorization': token},
      ),
    );
  }
}
