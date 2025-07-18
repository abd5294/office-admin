class Department {
  final int id;
  final String name;
  final String description;

  Department({required this.id, required this.name, required this.description});

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['ID'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'ID': id, 'name': name, 'description': description};
  }
}
