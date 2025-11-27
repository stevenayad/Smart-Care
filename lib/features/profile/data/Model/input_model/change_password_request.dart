class ChangePasswordRequest {
  final String email;
  final String newpassword;
  ChangePasswordRequest({required this.email, required this.newpassword});
  Map<String, dynamic> tojson() {
    return {'email': email, 'newPassword': newpassword};
  }
}
