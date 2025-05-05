import 'package:office/features/checkin/model/check_in_list_model.dart';

class CheckInListController {
  List<CheckInListModel> getCheckInList() {
    return [
      CheckInListModel('14th March'),
      CheckInListModel('14th January'),
      CheckInListModel('15th March'),
    ];
  }
}
