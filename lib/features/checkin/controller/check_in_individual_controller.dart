import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/features/checkin/model/check_in_individual_model.dart';
import 'package:office/features/checkin/repository/check_in_individual_repository.dart';

final checkInIndividualControllerProvider = AsyncNotifierProvider.family<
  CheckInIndividualController,
  List<CheckInIndividualModel>,
  CheckInRequestParams
>(CheckInIndividualController.new);

class CheckInIndividualController
    extends
        FamilyAsyncNotifier<
          List<CheckInIndividualModel>,
          CheckInRequestParams
        > {
  @override
  Future<List<CheckInIndividualModel>> build(
    CheckInRequestParams params,
  ) async {
    final repo = ref.read(checkInIndividualRepositoryProvider);
    final token = ref.read(userProvider)!.token;

    try {
      List<CheckInIndividualModel> resultRaw = await repo.getCheckInDetails(
        params.id,
        token,
      );
      final filteredList =
          resultRaw.where((e) {
            final formatDate = convertToIsoUtc(params.date);
            final bool isSameDate =
                formatDate.substring(0, 10) == e.time.substring(0, 10);
            return isSameDate;
          }).toList();

      final modelResult =
          filteredList.map((e) {
            final hoursTime = e.time.substring(11, 16);
            return CheckInIndividualModel(
              e.name,
              hoursTime,
              e.totalLeaves,
              e.timeString,
              e.type,
            );
          }).toList();

      CheckInIndividualModel? findFirst(
        List<CheckInIndividualModel> list,
        String type,
      ) {
        try {
          return list.firstWhere((e) => e.type == type);
        } catch (_) {
          return null;
        }
      }

      final checkIn =
          findFirst(modelResult, 'checkin') ??
          CheckInIndividualModel('N/A', '', 0, '', 'checkin');
      final checkOut =
          findFirst(modelResult, 'checkout') ??
          CheckInIndividualModel('N/A', '', 0, '', 'checkout');

      final result = [checkIn, checkOut];

      return result;
    } on DioException catch (e) {
      throw e.response!.data['error'];
    } catch (e) {
      print(e);
      throw 'Unexpected error occurred';
    }
  }

  String convertToIsoUtc(String date) {
    final parts = date.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final dateTime = DateTime.utc(year, month, day, 0, 0);
    return '${dateTime.toIso8601String()}Z';
  }
}

class CheckInRequestParams {
  final int id;
  final String date;

  CheckInRequestParams(this.id, this.date);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckInRequestParams &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date;

  @override
  int get hashCode => id.hashCode ^ date.hashCode;
}
