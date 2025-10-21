class RegisterValidator {
  static String? validateStep1({
    required String firstName,
    required String lastName,
    required String email,
    required String userName,
    required String phoneNumber,
  }) {
    if (firstName.trim().isEmpty) {
      return 'Please enter your first name';
    }
    if (lastName.trim().isEmpty) {
      return 'Please enter your last name';
    }
    if (userName.trim().isEmpty) {
      return 'Please enter your username';
    }
    if (phoneNumber.trim().isEmpty) {
      return 'Please enter your phone';
    }
    if (email.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateStep2({
    required String birthDate,
    required int? gender,
    required String password,
    required String confirmPassword,
  }) {
    if (birthDate.isEmpty) {
      return 'Please select your birth date';
    }
    if (gender == null) {
      return 'Please select your gender';
    }
    if (password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateStep3({
    required String address,
    required String addressLabel,
    required String addressadditionalLabel,
  }) {
    if (address.trim().isEmpty) {
      return 'Please enter your address';
    }
    if (addressLabel.trim().isEmpty) {
      return 'Please enter an address label (e.g., Home)';
    }
if (addressadditionalLabel.trim().isEmpty) {
      return 'Please enter an additional address  near to ain shams usniversity';
    }
    return null;
  }
}
