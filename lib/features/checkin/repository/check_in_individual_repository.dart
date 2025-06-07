import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/dio_provider.dart';
import 'package:office/features/checkin/model/check_in_individual_model.dart';

final checkInIndividualRepositoryProvider = Provider((ref) {
  return CheckInIndividualRepository(dio: ref.read(dioProvider));
});

class CheckInIndividualRepository {
  final Dio dio;

  CheckInIndividualRepository({required this.dio});

  Future<List<CheckInIndividualModel>> getCheckInDetails(
    int id,
    String token,
  ) async {
    final response = await dio.get(
      '/checks/$id',
      options: Options(headers: {'Authorization': token}),
    );
    final checkIns =
        (response.data['data'] as List)
            .map((el) => CheckInIndividualModel.fromMap(el))
            .toList();
    return checkIns;
  }
}
