import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/outof_stock.dart';

abstract class Failure {
  final String errMessage;
  final List<OutOfStock>? outOfStocks;
  const Failure(this.errMessage, this.outOfStocks);
}

class servivefailure extends Failure {
  servivefailure(String errMessage, {List<OutOfStock>? outOfStocks})
    : super(errMessage, outOfStocks);

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

  /*factory servivefailure.badResponse(int? statscode, dynamic respone) {
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
  }*/
  factory servivefailure.badResponse(int statusCode, dynamic response) {
    String errorMessage = "An unknown error occurred.";
    List<OutOfStock>? outOfStocks;

    if (response is String) {
      try {
        response = jsonDecode(response);
      } catch (_) {}
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response is Map<String, dynamic>) {
        if (response.containsKey('data') &&
            response['data'] is Map<String, dynamic> &&
            response['data'].containsKey('outOfStocks')) {
          final stockData = response['data']['outOfStocks'];

          if (stockData is List) {
            outOfStocks = stockData.map((e) => OutOfStock.fromJson(e)).toList();
          }
        }

        if (response.containsKey('message')) {
          errorMessage = response['message'];
        }
      }

      return servivefailure(errorMessage, outOfStocks: outOfStocks);
    }

    if (statusCode == 404) {
      return servivefailure("Your request was not found, please try again.");
    } else if (statusCode == 500) {
      return servivefailure("Internal server error, please try again later.");
    } else {
      return servivefailure("Oops, something went wrong!");
    }
  }
}
