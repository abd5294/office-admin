class Employee {
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
  final List<dynamic> emergencyContacts;

  Employee(
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
    this.emergencyContacts,
  );

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
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
