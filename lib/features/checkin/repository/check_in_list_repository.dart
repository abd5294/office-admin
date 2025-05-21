import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/checkin/model/check_in_list_model.dart';

final checkInListRepositoryProvider = Provider((ref) {
  return CheckInListRepository(dio: ref.read(dioProvider));
});

class CheckInListRepository {
  final Dio dio;

  CheckInListRepository({required this.dio});

  Future<List<CheckInListModel>> getCheckInDetails(int id, String token) async {
    final response = await dio.get(
      '/checks/$id',
      options: Options(headers: {'Authorization': token}),
    );

    final checkIns =
        (response.data['data'] as List)
            .map((el) => CheckInListModel.fromMap(el))
            .toList();
    return checkIns;
  }
}
