class UpdateEmployeeModel {
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String role;
  final String password;

  UpdateEmployeeModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'bloodType': bloodGroup,
      'role': role,
      'password': password,
    };
  }
}
