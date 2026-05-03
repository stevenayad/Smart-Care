import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
import 'package:smartcare/features/payment/data/paymentmethod/paymob_strategy.dart';
import 'package:smartcare/features/payment/data/paymentmethod/stripe_strategy.dart';

class PaymentFactory {
  static PaymentStrategy getStrategy(int provider) {
     switch(provider)
     {
      case 0: return StripePaymentStrategy();
      case 1: return PaymobPaymentStrategy();
      default: throw Exception("Unsupported provider");
     }
  }
}