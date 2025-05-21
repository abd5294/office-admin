class LeaveDetailsModel {
  final int id;
  final String type;
  final String date;
  final String reason;

  LeaveDetailsModel({
    required this.id,
    required this.type,
    required this.date,
    required this.reason,
  });

  factory LeaveDetailsModel.fromMap(Map<String, dynamic> map) {
    final rawDate = map['date'];
    final parsedDate = DateTime.tryParse(rawDate)!;
    String formattedDate =
        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    return LeaveDetailsModel(
      id: map['ID'],
      type: map['type'],
      date: formattedDate,
      reason: map['reason'],
    );
  }
}
