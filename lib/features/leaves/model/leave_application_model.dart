class LeaveApplicationModel {
  final String name;
  final String reason;
  final String type;
  final String date;
  final String choice;

  LeaveApplicationModel({
    required this.name,
    required this.reason,
    required this.type,
    required this.date,
    required this.choice,
  });

  factory LeaveApplicationModel.fromMap(Map<String, dynamic> map) {
    return LeaveApplicationModel(
      name: map['name'] ?? '',
      reason: map['reason'] ?? '',
      type: map['type'] ?? '',
      date: map['date'] ?? '',
      choice: map['choice'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'reason': reason,
      'type': type,
      'date': date,
      'choice': choice,
    };
  }
}
