import 'dart:convert';
import 'address.dart';
class Data {
  String? id;
  String? userName;
  String? email;
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
    this.userName,
    this.email,
    this.gender,
    this.profileImageUrl,
    this.birthDate,
    this.accountType,
    this.ratesCount,
    this.favoritesCount,
    this.ordersCount,
    this.addresses,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    id: data['id'] as String?,
    userName: data['userName'] as String?,
    email: data['email'] as String?,
    gender: data['gender'] as String?,
    profileImageUrl: data['profileImageUrl'] as String?,
    birthDate: data['birthDate'] as String?,
    accountType: data['accountType'] as String?,
    ratesCount: data['ratesCount'] as int?,
    favoritesCount: data['favoritesCount'] as int?,
    ordersCount: data['ordersCount'] as int?,
    addresses: (data['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'userName': userName,
    'email': email,
    'gender': gender,
    'profileImageUrl': profileImageUrl,
    'birthDate': birthDate,
    'accountType': accountType,
    'ratesCount': ratesCount,
    'favoritesCount': favoritesCount,
    'ordersCount': ordersCount,
    'addresses': addresses?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
