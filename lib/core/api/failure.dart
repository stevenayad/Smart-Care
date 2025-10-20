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

  factory servivefailure.badResponse(int? statscode, dynamic respone) {
    String errorMessage = "An unknown error occurred.";

    if (statscode == 400 || statscode == 401 || statscode == 403) {
      if (respone is Map<String, dynamic>) {
        if (respone.containsKey('error') && respone['error'] is Map) {
          if (respone['error'].containsKey('message')) {
            errorMessage = respone['error']['message'];
          }
        } else if (respone.containsKey('message')) {
          errorMessage = respone['message'];
        } else if (respone.containsKey('errors')) {
          if (respone['errors'] is Map) {
            errorMessage = respone['errors'].values.first.first;
          } else {
            errorMessage = "Invalid data provided.";
          }
        }
      }
      return servivefailure(errorMessage);
    } else if (statscode == 404) {
      return servivefailure("Your request was not found, please try again.");
    } else if (statscode == 500) {
      return servivefailure("Internal server error, please try again later.");
    } else {
      return servivefailure("Oops, something went wrong!");
    }
  }
}
