class UpdateEmployeeModel {
  final String name;
  final String email;
  final String phone;
  final String bloodGroup;
  final String gender;
  final String designation;
  final String address;
  final String dob;
  final bool? isDeactivated;

  UpdateEmployeeModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.gender,
    required this.designation,
    required this.address,
    required this.dob,
    this.isDeactivated = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Email': email,
      'Phone': phone,
      'BloodType': bloodGroup,
      'Designation': designation,
      'Address': address,
      'Gender': gender,
      'Dob': dob,
      'IsDeactivated': isDeactivated,
    };
  }
}
