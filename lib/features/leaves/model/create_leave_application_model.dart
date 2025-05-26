class CreateLeaveApplicationModel {
  final String reason;
  final String date;
  final String type;

  CreateLeaveApplicationModel({
    required this.reason,
    required this.date,
    required this.type,
  });

  factory CreateLeaveApplicationModel.fromMap(Map<String, dynamic> map) {
    return CreateLeaveApplicationModel(
      reason: map['reason'] ?? '',
      date: map['date'] ?? '',
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'reason': reason, 'date': date, 'type': type};
  }
}
