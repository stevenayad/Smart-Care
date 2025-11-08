import 'dart:convert';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class servivefailure extends Failure {
  servivefailure(super.errMessage);

  factory servivefailure.fromDioError(DioError dioerror) {
    switch (dioerror.type) {
      case DioExceptionType.connectionTimeout:
        return servivefailure("Connection timeout With Apiserver");
      case DioExceptionType.sendTimeout:
        return servivefailure("Send timeout With Apiserver");
      case DioExceptionType.receiveTimeout:
        return servivefailure("Recive timeout With Apiserver");
      case DioExceptionType.badCertificate:
        return servivefailure("lk");
      case DioExceptionType.badResponse:
        return servivefailure.badResponse(
          dioerror.response!.statusCode!,
          dioerror.response!.data!,
        );
      case DioExceptionType.cancel:
        return servivefailure("Request with api server was cancled");
      case DioExceptionType.connectionError:
        return servivefailure("Connection error");
      case DioExceptionType.unknown:
        if (dioerror.message!.contains("SocketException")) {
          return servivefailure("No Internet Connection");
        }
        return servivefailure("Un Expected error , please try again");

      default:
        return servivefailure("Opps error");
    }
  }

  factory servivefailure.badResponse(int statscode, dynamic Respone) {
    // 1. Check if the response is a raw string

    if (statscode == 401) {
      if (Respone == null || (Respone is String && Respone.trim().isEmpty)) {
        // Return a specific message for 401 with an empty body
        return servivefailure(
          'Unauthorized: Access Token is invalid or missing. Please log in again.',
        );
      }
    }

    if (Respone is String) {
      try {
        // Decode the JSON string into a Map
        Respone = jsonDecode(Respone);
      } catch (e) {
        // Return a generic error if the string can't be decoded
        return servivefailure('Error: Failed to parse server error response.');
      }
    }

    // 2. Now, safely access the 'message' key as a Map
    if (Respone is Map && Respone.containsKey('message')) {
      // Safely cast the message to String before returning
      return servivefailure(Respone['message'] as String);
    }

    // 3. Fallback for any unexpected structure
    return servivefailure(
      'Server error with status $statscode and unknown message format.',
    );
  }
}
