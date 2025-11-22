import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openPaymentLink(String url, BuildContext context) async {
  if (url.isNotEmpty) {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open payment link")),
      );
    }
  }
}
