class LeaveDetailsModel {
  final String type;
  final String date;

  LeaveDetailsModel({required this.type, required this.date});

  factory LeaveDetailsModel.fromMap(Map<String, dynamic> map) {
    return LeaveDetailsModel(type: map['status'], date: map['date']);
  }
}
