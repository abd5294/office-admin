class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['ID'] ?? '',
      name: map['Name'] ?? '',
      email: map['Email'] ?? '',
      role: map['Role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'Id': id, 'Name': name, 'Email': email, 'Role': role};
  }
}
