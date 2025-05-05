import 'package:office/shared/models/leave_timeline_model.dart';

class FestivalLeaveController {
  List<LeaveTimeLineModel> getFestivalLeaves() {
    return [
      LeaveTimeLineModel(
        date: '12th March',
        message: 'Holiday on account of Eid',
        note: 'Happy eid',
      ),
      LeaveTimeLineModel(
        date: '12th April',
        message: 'Holiday on account of Eid',
        note: 'Happy eid',
      ),
      LeaveTimeLineModel(
        date: '12th May',
        message: 'Holiday on account of Eid',
        note: 'Happy eid',
      ),
    ];
  }
}
