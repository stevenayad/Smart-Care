import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
import 'package:smartcare/features/payment/data/repo/payment_servcies.dart';

class PaymobPaymentStrategy implements PaymentStrategy {
  @override
  Future<void> pay(String clientSecret) async {
    await PaymobRedirectService.startPayment(
      clientSecret: clientSecret,
    );
  }
}