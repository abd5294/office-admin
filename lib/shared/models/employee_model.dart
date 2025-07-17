class EmployeeModel {
  final int id;
  final String name;
  final String role;
  final String email;
  final String employeeId;
  final int totalLeaves;
  final String designation;
  final String address;
  final String bloodType;
  final String gender;
  final String phone;
  final String dob;
  final String dateOfJoining;
  final String department;
  final List<dynamic> emergencyContacts;

  EmployeeModel(
    this.id,
    this.name,
    this.role,
    this.email,
    this.employeeId,
    this.totalLeaves,
    this.designation,
    this.address,
    this.bloodType,
    this.gender,
    this.phone,
    this.dob,
    this.dateOfJoining,
    this.department,
    this.emergencyContacts,
  );

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      map['ID'],
      map['Name'] ?? '',
      map['Role'],
      map['Email'],
      map['EmployeeID'] ?? 0,
      map['TotalLeaves'],
      map['Designation'],
      map['Address'],
      map['BloodType'],
      map['Gender'],
      map['Phone'],
      map['DOB'],
      map['DateOfJoining'],
      map['Department']['name'],
      map['EmergencyContacts'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Name': name,
      'Role': role,
      'Email': email,
      'EmployeeID': employeeId,
      'TotalLeaves': totalLeaves,
      'Designation': designation,
      'Address': address,
      'BloodType': bloodType,
      'Gender': gender,
      'Phone': phone,
      'DOB': dob,
      'EmergencyContacts': emergencyContacts,
    };
  }
}
