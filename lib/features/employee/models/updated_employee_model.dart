class UpdateEmployeeModel {
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String password;
  final String gender;
  final String designation;
  final String address;
  final String dob;

  UpdateEmployeeModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.password,
    required this.gender,
    required this.designation,
    required this.address,
    required this.dob,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Email': email,
      'Phone': phone,
      'BloodType': bloodGroup,
      'Password': password,
      'Designation': designation,
      'Address': address,
      'Gender' : gender,
      'Dob': dob,
    };
  }
}
