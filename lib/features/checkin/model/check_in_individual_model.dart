class CheckInIndividualModel {
  final String name;
  final String time;

  CheckInIndividualModel(this.name, this.time);

  factory CheckInIndividualModel.fromMap(Map<String, dynamic> map) {
    return CheckInIndividualModel(map['name'], map['CreatedAt']);
  }
}
