class CreateLeaveApplicationModel {
  final String reason;
  final String date;
  final String type;
  final String kind;

  CreateLeaveApplicationModel({
    required this.reason,
    required this.date,
    required this.type,
    required this.kind,
  });

  factory CreateLeaveApplicationModel.fromMap(Map<String, dynamic> map) {
    return CreateLeaveApplicationModel(
      reason: map['reason'] ?? '',
      date: map['date'] ?? '',
      type: map['type'] ?? '',
      kind: map['kind'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'reason': reason, 'date': date, 'type': type, 'kind': kind};
  }
}
