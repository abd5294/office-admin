class FestivalLeaveModel {
  final int? id;
  final String date;
  final String occasion;
  final String type;

  FestivalLeaveModel({
    required this.date,
    required this.occasion,
    required this.type,
    this.id,
  });

  factory FestivalLeaveModel.fromMap(Map<String, dynamic> map) {
    return FestivalLeaveModel(
      date: map['date'],
      occasion: map['reason'],
      type: map['type'],
      id: map['ID'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reason': occasion,
      'type': type,
      'ID': id,
    };
  }
}