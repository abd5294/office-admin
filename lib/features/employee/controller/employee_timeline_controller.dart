import 'package:office/shared/models/leave_timeline_model.dart';

class EmployeeTimeLineController {
  List<LeaveTimeLineModel> getEmployeeTimeLine() {
    return [
      LeaveTimeLineModel(date: '12th March', type: 'Approved'),
      LeaveTimeLineModel(date: '16th March', type: 'Half leave'),
      LeaveTimeLineModel(date: '19th March', type: 'Unapproved'),
    ];
  }
}
