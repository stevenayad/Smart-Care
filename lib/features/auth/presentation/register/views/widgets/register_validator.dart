class RegisterValidator {
  static String? validateFields({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    username = username.trim();
    phone = phone.trim();
    email = email.trim();

    if (username.isEmpty) {
      return 'Please enter your username';
    } else if (phone.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phone)) {
      return 'Enter a valid phone number';
    } else if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Enter a valid email address';
    } else if (password.isEmpty) {
      return 'Please enter your password';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
