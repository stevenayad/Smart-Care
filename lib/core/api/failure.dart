import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/outof_stock.dart';

abstract class Failure {
  final String errMessage;
  final List<OutOfStock>? outOfStocks;

  const Failure(this.errMessage, this.outOfStocks);
}

class servivefailure extends Failure {
  servivefailure(
    String errMessage, {
    List<OutOfStock>? outOfStocks,
  }) : super(errMessage, outOfStocks);

  factory servivefailure.fromDioError(DioException dioerror) {
    switch (dioerror.type) {
      case DioExceptionType.connectionTimeout:
        return servivefailure(
          "Connection timeout with API server",
        );

      case DioExceptionType.sendTimeout:
        return servivefailure(
          "Send timeout with API server",
        );

      case DioExceptionType.receiveTimeout:
        return servivefailure(
          "Receive timeout with API server",
        );

      case DioExceptionType.badCertificate:
        return servivefailure(
          "Bad certificate error",
        );

      case DioExceptionType.badResponse:
        return servivefailure.badResponse(
          dioerror.response?.statusCode ?? 0,
          dioerror.response?.data,
        );

      case DioExceptionType.cancel:
        return servivefailure(
          "Request was cancelled",
        );

      case DioExceptionType.connectionError:
        return servivefailure(
          "Connection error",
        );

      case DioExceptionType.unknown:
        if (dioerror.message != null &&
            dioerror.message!.contains("SocketException")) {
          return servivefailure(
            "No Internet Connection",
          );
        }

        return servivefailure(
          "Unexpected error, please try again",
        );

      default:
        return servivefailure(
          "Oops! Something went wrong",
        );
    }
  }

  factory servivefailure.badResponse(
    int statusCode,
    dynamic response,
  ) {
    String errorMessage = "An unknown error occurred.";
    List<OutOfStock>? outOfStocks;

    try {
      if (response is String) {
        response = jsonDecode(response);
      }

      if (response is Map<String, dynamic>) {
        // =========================
        // Handle Out Of Stock
        // =========================
        final data = response['data'];

        if (data is Map<String, dynamic>) {
          final stockData = data['outOfStocks'];

          if (stockData is List) {
            outOfStocks = stockData
                .map((e) => OutOfStock.fromJson(e))
                .toList();
          }
        }

        // =========================
        // Handle Validation Errors
        // =========================
        final errorsBag = response['errorsBag'];

        if (errorsBag is Map<String, dynamic> &&
            errorsBag.isNotEmpty) {
          List<String> errors = [];

          errorsBag.forEach((key, value) {
            if (value is List) {
              errors.addAll(
                value.map((e) => e.toString()),
              );
            }
          });

          if (errors.isNotEmpty) {
            errorMessage = errors.join('\n');
          }
        }

        // =========================
        // Handle Normal Message
        // =========================
        else if (response['message'] != null &&
            response['message'].toString().isNotEmpty) {
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
        return servivefailure(
          errorMessage,
          outOfStocks: outOfStocks,
        );

      case 404:
        return servivefailure(
          "Your request was not found, please try again.",
        );

      case 500:
        return servivefailure(
          "Server Busy, please try again later.",
        );

      default:
        return servivefailure(
          "Oops! Something went wrong.",
        );
    }
  }
}