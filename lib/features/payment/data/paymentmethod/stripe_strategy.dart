import 'package:flutter/material.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
import 'package:smartcare/features/payment/data/services/payment_servcies.dart';

class StripePaymentStrategy implements PaymentStrategy {
  @override
  Future<void> pay(BuildContext context,String clientSecret) async {
    await StripeServices.payWithStripe(clientSecret);
  }
  
  @override
  String get providerName => "Stripe";
}


