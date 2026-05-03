import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:url_launcher/url_launcher.dart';

class StripeServices {
  /// 💳 Stripe Payment
  static Future<void> payWithStripe(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Smart Care',
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    print('Stripe Payment Completed ✅');
  }
}

class PaymobRedirectService {
  static const String _baseUrl = "https://accept.paymob.com/unifiedcheckout/";

  static const String _publicKey =
      "egy_pk_test_4plD7odtSodIa4hxuozp1F1Y0l1NIWlj";

  /// 🟢 Create Payment URL
  static String buildPaymentUrl(String clientSecret) {
    return "$_baseUrl?publicKey=$_publicKey&clientSecret=$clientSecret";
  }

  static Future<void> startPayment({required String clientSecret}) async {
    final url = buildPaymentUrl(clientSecret);

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw Exception("Could not launch payment page");
    }
  }
}
