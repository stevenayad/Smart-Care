import 'package:flutter/material.dart';

abstract class PaymentStrategy {
    String get providerName; 
  Future<void> pay(BuildContext context,String clientSecret);
}