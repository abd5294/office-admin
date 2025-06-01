class UpdatePasswordModel {
  final String password;
  final String? confirmPassword;
  final String email;
  final int otp;

  UpdatePasswordModel({
    required this.password,
    required this.email,
    required this.otp,
    this.confirmPassword,
  });
  Map<String, dynamic> toMap() {
    return {'password': password, 'email': email, 'otp': otp};
  }

  // factory UpdatePasswordModel.fromMap(Map<String, dynamic> map) {
  //   return UpdatePasswordModel(
  //     password: map['password'] ?? '',
  //     email: map['email'] ?? '',
  //     otp:
  //         map['otp'] is String
  //             ? int.tryParse(map['otp']) ?? 0
  //             : map['otp'] ?? 0,
  //   );
  // }
}
