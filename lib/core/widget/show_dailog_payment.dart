import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/Orders/domain/repositories/order_repository_impl.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_bloc.dart';
import 'package:smartcare/features/Orders/presentation/view/screen/orders_screen.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/main.dart';

class SmartDialogPayment extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;

  const SmartDialogPayment({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    
  });

  @override
  State<SmartDialogPayment> createState() => _SmartDialogState();
}

class _SmartDialogState extends State<SmartDialogPayment>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
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
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.pop(context);

                
                Navigator.push(
                  navigatorKey.currentState!.context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => OrdersBloc(
                        repository: OrderRepositoryImpl(
                          apiConsumer: DioConsumer(Dio()),
                        ),
                      ),
                      child: OrdersScreen(),
                    ),
                  ),
                );
              

           
            },

            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

void showGlobalPaymntCancelledDialog(String message) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    barrierDismissible: false,
    builder: (context) => SmartDialogPayment(

      icon: Icons.cancel,
      iconColor: Colors.red,
      title:  "Order Cancelled",
      message: message,
    ),
  );
}

void showGlobalPaymentSuccessDialog(String message) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    barrierDismissible: false,
    builder: (context) => SmartDialogPayment(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      title:"Order Success" ,
      message: message,
    ),
  );
}

void showLoadingDialog() {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}
