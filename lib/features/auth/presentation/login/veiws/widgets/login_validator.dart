class LoginValidator {
  static String? validateFields({
    required String email,
    required String password,
  }) {
    if (email.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Enter a valid email address';
    } else if (password.isEmpty) {
      return 'Please enter your password';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
}
