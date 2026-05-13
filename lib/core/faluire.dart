import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/outof_stock.dart';

abstract class Failure {
  final String errMessage;
  final List<OutOfStock>? outOfStocks;

  const Failure({required this.errMessage, this.outOfStocks});
}

class servivefailure extends Failure {
  servivefailure(String errMessage, {List<OutOfStock>? outOfStocks})
    : super(errMessage: errMessage, outOfStocks: outOfStocks);

  factory servivefailure.fromDioError(DioException dioerror) {
    switch (dioerror.type) {
      case DioExceptionType.connectionTimeout:
        return servivefailure("Connection timeout with API server");

      case DioExceptionType.sendTimeout:
        return servivefailure("Send timeout with API server");

      case DioExceptionType.receiveTimeout:
        return servivefailure("Receive timeout with API server");

      case DioExceptionType.badCertificate:
        return servivefailure("Bad certificate error");

      case DioExceptionType.badResponse:
        return servivefailure.badResponse(
          dioerror.response?.statusCode ?? 0,
          dioerror.response?.data,
        );

      case DioExceptionType.cancel:
        return servivefailure("Request was cancelled");

      case DioExceptionType.connectionError:
        return servivefailure("Connection error");

      case DioExceptionType.unknown:
        if (dioerror.message != null &&
            dioerror.message!.contains("SocketException")) {
          return servivefailure("No Internet Connection");
        }

        return servivefailure("Unexpected error, please try again");

      default:
        return servivefailure("Oops! Something went wrong");
    }
  }

  factory servivefailure.badResponse(int statusCode, dynamic response) {
    String errorMessage = "An unknown error occurred.";
    List<OutOfStock>? outOfStocks;

    try {
      // لو الريسبونس String نحوله JSON
      if (response is String) {
        response = jsonDecode(response);
      }

      if (response is Map<String, dynamic>) {
        // =========================
        // Handle Out Of Stock
        // =========================
        if (response.containsKey('data') &&
            response['data'] is Map<String, dynamic>) {
          final data = response['data'];

          if (data.containsKey('outOfStocks')) {
            final stockData = data['outOfStocks'];

            if (stockData is List) {
              outOfStocks = stockData
                  .map((e) => OutOfStock.fromJson(e))
                  .toList();
            }
          }
        }

        // =========================
        // Handle Validation Errors
        // =========================
        if (response.containsKey('errorsBag') &&
            response['errorsBag'] is Map<String, dynamic>) {
          final errorsBag = response['errorsBag'] as Map<String, dynamic>;

          List<String> allErrors = [];

          errorsBag.forEach((key, value) {
            if (value is List) {
              allErrors.addAll(value.map((e) => e.toString()));
            }
          });

          if (allErrors.isNotEmpty) {
            errorMessage = allErrors.join('\n');
          }
        }
        // =========================
        // Handle Normal Message
        // =========================
        else if (response.containsKey('message') &&
            response['message'] != null) {
          errorMessage = response['message'].toString();
        }
      }
    } catch (e) {
      errorMessage = "Unexpected server error";
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return servivefailure(errorMessage, outOfStocks: outOfStocks);

      case 404:
        return servivefailure("Your request was not found, please try again.");

      case 500:
        return servivefailure("Internal server error, please try again later.");

      default:
        return servivefailure("Oops! Something went wrong.");
    }
  }
}
