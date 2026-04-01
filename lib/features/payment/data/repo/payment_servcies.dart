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

/*class PaymobService {
  /// 🟢 Start Payment
  static Future<PaymobPaymentResult?> startPayment({
    required String clientSecret,
  }) async {
    try {
      final result = await Paymob.pay(
        publicKey: 'egy_pk_test_4plD7odtSodIa4hxuozp1F1Y0l1NIWlj',
        clientSecret: clientSecret,
        appName: 'Smart Care',
        buttonBackgroundColor: Colors.blue,
        buttonTextColor: Colors.white,
        saveCardDefault: false,
        showSaveCard: true,
      );

      return result;
    } catch (e) {
      debugPrint("Paymob Error: $e");
      return null;
    }
  }

  static void handlePaymentResult({
    required PaymobPaymentResult? result,
    required VoidCallback onSuccess,
    required VoidCallback onPending,
    required Function(String error) onError,
  }) {
    if (result == null) {
      onError("Something went wrong");
      return;
    }

    switch (result.status) {
      case PaymobTransactionStatus.successful:
        debugPrint("✅ Payment Success");
        debugPrint("Transaction: ${result.transactionDetails}");

        onSuccess();
        break;

      case PaymobTransactionStatus.pending:
        debugPrint("⏳ Payment Pending");
        onPending();
        break;

      case PaymobTransactionStatus.rejected:
        debugPrint("❌ Payment Rejected");
        onError("Payment was rejected");
        break;

      case PaymobTransactionStatus.unknown:
        debugPrint("⚠️ Unknown Status");
        onError(result.errorMessage ?? "Unknown error");
        break;
    }
  }
}*/
