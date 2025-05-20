class CheckInListModel {
  final String date;

  CheckInListModel(this.date);

  factory CheckInListModel.fromMap(Map<String, dynamic> map) {
    return CheckInListModel(
      map['createdAt'],
    );
  }
}
