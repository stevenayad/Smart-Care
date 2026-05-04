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
      case 10:
        return "Waiting for Pickup";
      case 11:
        return "Ready to Ship";
      case 12:
        return "Delivery Accepted";
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
      case 10:
        return Colors.teal; // Waiting pickup
      case 11:
        return Colors.cyan; // Ready to ship
      case 12:
        return Colors.greenAccent; // Accepted
      default:
        return Colors.grey;
    }
  }

  static Color getStatusTextColor(int? status) {
    switch (status) {
      case 0:
      case 2:
      case 10:
      case 11:
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  static IconData getStatusIcon(int? status) {
    switch (status) {
      case 0:
        return Icons.hourglass_empty_rounded;
      case 1:
        return Icons.sync_rounded;
      case 2:
        return Icons.local_shipping_outlined;
      case 3:
        return Icons.check_circle_outline_rounded;
      case 4:
        return Icons.cancel_outlined;
      case 5:
        return Icons.thumb_up_alt_outlined;
      case 6:
        return Icons.keyboard_return_rounded;
      case 7:
        return Icons.credit_card_off_outlined;
      case 8:
        return Icons.timer_off_outlined;
      case 9:
        return Icons.currency_exchange_rounded;
      case 10:
        return Icons.store_mall_directory_outlined; // pickup
      case 11:
        return Icons.inventory_2_outlined; // ready
      case 12:
        return Icons.delivery_dining_outlined; // accepted
      default:
        return Icons.help_outline_rounded;
    }
  }
}