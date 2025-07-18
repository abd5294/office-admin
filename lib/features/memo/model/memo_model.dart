import 'package:office/features/memo/model/department_model.dart';

class Memo {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final Department? department;

  Memo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.department,
  });

  factory Memo.fromMap(Map<String, dynamic> json) => Memo(
    id: json['ID'],
    title: json['title'],
    description: json['description'],
    createdAt: DateTime.parse(json['CreatedAt']),
    department:
        json['department'] != null
            ? Department.fromMap(json['department'])
            : null,
  );

  Map<String, dynamic> toMap() => {
    'ID': id,
    'title': title,
    'description': description,
    'CreatedAt': createdAt.toIso8601String(),
    'department': department?.toMap(),
  };
}
