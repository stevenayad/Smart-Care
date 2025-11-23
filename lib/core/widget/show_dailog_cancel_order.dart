import 'package:flutter/material.dart';
import 'package:smartcare/main.dart';


class SmartDialog extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;

  const SmartDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
  });

  @override
  State<SmartDialog> createState() => _SmartDialogState();
}

class _SmartDialogState extends State<SmartDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: AlertDialog(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.iconColor.withOpacity(.2),
              radius: 22,
              child: Icon(widget.icon, color: widget.iconColor, size: 28),
            ),
            const SizedBox(width: 12),
            Text(widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Text(
          widget.message,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        actionsPadding: const EdgeInsets.only(right: 16, bottom: 12),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.iconColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
void showGlobalOrderCancelledDialog(String message) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    barrierDismissible: false,
    builder: (context) => SmartDialog(
      icon: Icons.cancel,
      iconColor: Colors.red,
      title: "Order Cancelled",
      message: message,
    ),
  );
}

void showGlobalOrderSuccessDialog(String message) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    barrierDismissible: false,
    builder: (context) => SmartDialog(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      title: "Order Successful",
      message: message,
    ),
  );
}

