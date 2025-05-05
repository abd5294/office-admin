class Employee {
  final String name;
  final int attendance;
  final String? email;
  final String? phone;
  final String? bloodGroup;
  final String? role;
  final int? approvedLeave;
  final int? unapprovedLeave;
  final int? remainingLeave;
  final int? totalAllowedUnapproved;
  final int? totalLeaves;

  Employee(
    this.name,
    this.attendance, [
    this.email,
    this.phone,
    this.bloodGroup,
    this.role,
    this.approvedLeave,
    this.unapprovedLeave,
    this.remainingLeave,
    this.totalAllowedUnapproved,
    this.totalLeaves,
  ]);
}
