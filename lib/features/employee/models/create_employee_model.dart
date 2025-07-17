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
  final String dob;
  final String department;
  final String dateOfJoining;
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
    required this.department,
    required this.dateOfJoining,
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
      'DateOfJoining': dateOfJoining,
      'department': department,
    };
  }
}
