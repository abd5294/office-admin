class CreateEmployeeModel {
  final String name;
  final String role;
  final String email;
  final String password;
  final String employeeID;
  final int totalLeaves;
  final String designation;
  final String address;
  final String bloodType;
  final String gender;
  final String phone;
  final String dob; // ISO 8601 format: "1990-01-01T00:00:00Z"
  final List<String> emergencyContacts;

  CreateEmployeeModel({
    required this.name,
    required this.role,
    required this.email,
    required this.password,
    required this.employeeID,
    required this.totalLeaves,
    required this.designation,
    required this.address,
    required this.bloodType,
    required this.gender,
    required this.phone,
    required this.dob,
    required this.emergencyContacts,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
      'email': email,
      'password': password,
      'employeeID': employeeID,
      'totalLeaves': totalLeaves,
      'designation': designation,
      'address': address,
      'bloodType': bloodType,
      'gender': gender,
      'phone': phone,
      'DOB': dob,
      'emergencyContacts': emergencyContacts,
    };
  }
}
