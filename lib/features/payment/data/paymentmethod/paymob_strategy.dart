/*import 'package:flutter/material.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
import 'package:smartcare/features/payment/data/services/payment_servcies.dart';

class PaymobPaymentStrategy implements PaymentStrategy {
  @override
  Future<void> pay(BuildContext context, String clientSecret) async {
    await PaymobRedirectService.startPayment(
      context: context,
      clientSecret: clientSecret,
    );
  }
  
  @override
  String get providerName => "Paymob";
}*/