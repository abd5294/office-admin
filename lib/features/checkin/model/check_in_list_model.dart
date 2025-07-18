class CheckInListModel {
  final String date;
  final String time;

  CheckInListModel(this.date, this.time);

  factory CheckInListModel.fromMap(Map<String, dynamic> map) {
    return CheckInListModel(map['createdAt'], map['timeString']);
  }
}
