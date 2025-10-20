class EditProfileRequest {
  String? firstName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? birthDate;
  int? gender;
  int? accountType;

  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.userName,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.accountType,
  });


  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return EditProfileRequest(
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      accountType: json['accountType'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'gender': gender,
      'accountType': accountType,
    };
  }
}
