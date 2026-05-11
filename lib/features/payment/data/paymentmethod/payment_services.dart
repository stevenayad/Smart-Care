import 'package:flutter/material.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
class PaymentService {
    final Map<int, PaymentStrategy> strategies;

  PaymentService({required this.strategies});

   Future<void> pay(BuildContext context,  String clientSecret, int provider) async {
    final strategy = strategies[provider];

    if (strategy == null) {
      throw Exception("Unsupported provider");
    }

    await strategy.pay(context,clientSecret);
  }
}