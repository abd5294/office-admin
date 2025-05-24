import 'leave_details_model.dart';

class EmployeeDetailsModel {
  final Map<String, dynamic> user;
  final Map<String, dynamic> leaves;
  final List<LeaveDetailsModel> holidays;

  EmployeeDetailsModel({
    required this.user,
    required this.leaves,
    required this.holidays,
  });

  factory EmployeeDetailsModel.fromMap(Map<String, dynamic> map) {
    return EmployeeDetailsModel(
      user: Map<String, dynamic>.from(map['user']),
      leaves: Map<String, dynamic>.from(map['leave_stats']),
      holidays:
          (map['analysis'] as List)
              .map((item) => LeaveDetailsModel.fromMap(item))
              .toList(),
    );
  }
}
