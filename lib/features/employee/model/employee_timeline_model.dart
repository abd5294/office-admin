class EmployeeTimeLine {
  final String type;
  final String date;

  EmployeeTimeLine(this.type, this.date);
}

class EmployeeTimeLineModel {
  List getEmployeeTimeLine() {
    return [
      EmployeeTimeLine('Approved', '12th March'),
      EmployeeTimeLine('Half leave', '16th March'),
      EmployeeTimeLine('unapproved', '19th March'),
    ];
  }
}
