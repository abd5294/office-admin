class CheckInIndividualModel {
  final String name;
  final String time;
  final int totalLeaves;
  final String timeString;
  final String type;

  CheckInIndividualModel(
    this.name,
    this.time,
    this.totalLeaves,
    this.timeString,
    this.type,
  );

  factory CheckInIndividualModel.fromMap(Map<String, dynamic> map) {
    return CheckInIndividualModel(
      map['User']['name'] ?? '',
      map['createdAt'] ?? '',
      map['User']['totalLeaves'] ?? 0,
      map['timeString'] ?? '',
      map['type'],
    );
  }
}
