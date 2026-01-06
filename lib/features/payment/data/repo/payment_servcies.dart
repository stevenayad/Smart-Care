import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentServcies {
  static Future<void> payOrder(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Smart Care',
      ),
    );
      print('init Payment Complted');
    await Stripe.instance.presentPaymentSheet();
    print('Payment Complted');
  }
}
