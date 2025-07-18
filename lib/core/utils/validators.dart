String? validatePassword(String? password, String? confirmPassword) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (password != confirmPassword) {
    return 'Password and confirm password must be same';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? validateOtp(String? value) {
  if (value == null || value.isEmpty) {
    return 'OTP is required';
  }
  if (value.length != 6) {
    return 'OTP must be 6 digits';
  }
  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'OTP must be numeric';
  }
  return null;
}
