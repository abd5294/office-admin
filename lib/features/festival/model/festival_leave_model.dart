class FestivalLeaveModel {
  final String date;
  final String reason;
  final String type;

  FestivalLeaveModel({
    required this.date,
    required this.reason,
    required this.type,
  });

  factory FestivalLeaveModel.fromMap(Map<String, dynamic> map) {
    return FestivalLeaveModel(
      date: map['date'],
      reason: map['reason'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reason': reason,
      'type': type,
    };
  }
}