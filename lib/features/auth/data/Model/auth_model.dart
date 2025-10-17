// NEW: This file now contains two models to handle the different responses from the login and sign-up APIs.

class RegisterResponseModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  Map<String, dynamic>? errorsBag; 
  bool? data;

  RegisterResponseModel(
      {this.statusCode,
      this.succeeded,
      this.message,
      this.errorsBag,
      this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    errorsBag = json['errorsBag'];
    data = json['data'];
  }
}

// NEW: Model for the Login API Response
class LoginResponseModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  Map<String, dynamic>? errorsBag;
  LoginData? data;

  LoginResponseModel(
      {this.statusCode,
      this.succeeded,
      this.message,
      this.errorsBag,
      this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    errorsBag = json['errorsBag'];
    // Check if 'data' is not null before parsing
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
}

// NEW: A dedicated class for the nested 'data' object in the login response.
class LoginData {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? accessTokenExpiresAt;
  String? refreshTokenExpiresAt;

  LoginData(
      {this.accessToken,
      this.refreshToken,
      this.tokenType,
      this.accessTokenExpiresAt,
      this.refreshTokenExpiresAt});

  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
    accessTokenExpiresAt = json['accessTokenExpiresAt'];
    refreshTokenExpiresAt = json['efreshTokenExpiresAt']; // Typo in API doc? Assuming 'refreshTokenExpiresAt'
  }
}