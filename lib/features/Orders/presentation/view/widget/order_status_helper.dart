import 'package:flutter/material.dart';

class OrderStatusHelper {
  static String getStatusText(int? status) {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Processing";
      case 2:
        return "Shipped";
      case 3:
        return "Completed";
      case 4:
        return "Cancelled";
      case 5:
        return "Confirmed";
      case 6:
        return "Returned";
      case 7:
        return "Payment Failed";
      case 8:
        return "Expired";
      case 9:
        return "Refunded";
      default:
        return "Unknown";
    }
  }

  static Color getStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.lightBlue;
      case 2:
        return Colors.indigo;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      case 5:
        return Colors.blueAccent;
      case 6:
        return Colors.orange;
      case 7:
        return Colors.deepOrange;
      case 8:
        return Colors.grey;
      case 9:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static Color getStatusTextColor(int? status) {
    if (status == 0 || status == 2) return Colors.black;
    return Colors.white;
  }

  static IconData getStatusIcon(int? status) {
    switch (status) {
      case 0:
        return Icons.hourglass_empty_rounded; // Pending
      case 1:
        return Icons.sync_rounded; // Processing
      case 2:
        return Icons.local_shipping_outlined; // Shipped
      case 3:
        return Icons.check_circle_outline_rounded; // Completed
      case 4:
        return Icons.cancel_outlined; // Cancelled
      case 5:
        return Icons.thumb_up_alt_outlined; // Confirmed
      case 6:
        return Icons.keyboard_return_rounded; // Returned
      case 7:
        return Icons.credit_card_off_outlined; // Payment Failed
      case 8:
        return Icons.timer_off_outlined; // Expired
      case 9:
        return Icons.currency_exchange_rounded; // Refunded
      default:
        return Icons.help_outline_rounded;
    }
  }
}
