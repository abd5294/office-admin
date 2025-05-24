class LeaveDetailsModel {
  final String type;
  final String date;

  LeaveDetailsModel({
    required this.type,
    required this.date,
  });

  factory LeaveDetailsModel.fromMap(Map<String, dynamic> map) {
    final rawDate = map['date'];
    final parsedDate = DateTime.tryParse(rawDate)!;
    String formattedDate =
        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    return LeaveDetailsModel(
      type: map['status'],
      date: formattedDate,
    );
  }
}
