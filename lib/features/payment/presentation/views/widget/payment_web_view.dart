import 'package:flutter/material.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String url;

  const PaymentWebView({super.key, required this.url});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Payment',
        showBackButton: true,
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreenView()),
          );
        },
      ),

      body: WebViewWidget(controller: controller),
    );
  }
}
