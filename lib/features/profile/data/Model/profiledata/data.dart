import 'address.dart';

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? profileImageUrl;
  String? birthDate;
  String? accountType;
  int? ratesCount;
  int? favoritesCount;
  int? ordersCount;
  List<Address>? addresses;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.gender,
    this.profileImageUrl,
    this.birthDate,
    this.accountType,
    this.ratesCount,
    this.favoritesCount,
    this.ordersCount,
    this.addresses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    userName: json['userName'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    gender: json['gender'] as String?,
    profileImageUrl: json['profileImageUrl'] as String?,
    birthDate: json['birthDate'] as String?,
    accountType: json['accountType'] as String?,
    ratesCount: json['ratesCount'] as int?,
    favoritesCount: json['favoritesCount'] as int?,
    ordersCount: json['ordersCount'] as int?,
    addresses: (json['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'userName': userName,
    'email': email,
    'phoneNumber': phoneNumber,
    'gender': gender,
    'profileImageUrl': profileImageUrl,
    'birthDate': birthDate,
    'accountType': accountType,
    'ratesCount': ratesCount,
    'favoritesCount': favoritesCount,
    'ordersCount': ordersCount,
    'addresses': addresses?.map((e) => e.toJson()).toList(),
  };
}
