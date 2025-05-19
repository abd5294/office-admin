class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String token) {
    return UserModel(
      token: token,
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
