class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String designation;
  final String address;
  final String gender;
  final String dob;
  final String phone;
  final String bloodGroup;
  final List<dynamic> emergencyContacts;
  final String token;
  final String department;
  final String dateOfJoining;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
    required this.designation,
    required this.address,
    required this.gender,
    required this.dob,
    required this.bloodGroup,
    required this.emergencyContacts,
    required this.phone,
    required this.department,
    required this.dateOfJoining,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String token) {
    return UserModel(
      id: map['ID'] ?? 0,
      name: map['Name'] ?? '',
      email: map['Email'] ?? '',
      role: map['Role'] ?? '',
      designation: map['Designation'] ?? '',
      address: map['Address'] ?? '',
      gender: map['Gender'] ?? '',
      dob: map['DOB'] ?? '',
      bloodGroup: map['BloodType'],
      phone: map['Phone'] ?? '',
      emergencyContacts: map['EmergencyContacts'] ?? '',
      token: token,
      department: map['Department']['name'],
      dateOfJoining: map['DateOfJoining'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Name': name,
      'Email': email,
      'Role': role,
      'Designation': designation,
      'Address': address,
      'Gender': gender,
      'DOB': dob,
      'BloodType': bloodGroup,
      'Phone': phone,
      'EmergencyContacts': emergencyContacts,
      'Token': token,
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    String? designation,
    String? address,
    String? gender,
    String? dob,
    String? phone,
    String? bloodGroup,
    List<dynamic>? emergencyContacts,
    String? token,
    bool? isDeactivated,
    String? dateOfJoining,
    String? department,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      designation: designation ?? this.designation,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      token: token ?? this.token,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      department: department ?? this.department,
    );
  }
}
