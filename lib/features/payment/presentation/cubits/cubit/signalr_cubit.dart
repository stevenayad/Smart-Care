import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/show_dailog_cancel_order.dart';
import 'package:smartcare/features/payment/data/repo/payment_signalr.dart';
import 'package:smartcare/features/payment/presentation/cubits/cubit/signalr_state.dart';
import 'package:smartcare/main.dart';

class PaymentSignalRCubit extends Cubit<PaymentSignalRState> {
  final PaymentSignalr signalRService;

  Function(OrderResponse model)? onPaymentMessage;
  bool _isLoadingVisible = false;

  PaymentSignalRCubit({required this.signalRService})
    : super(PaymentSignalRState()) {
    _init();
  }

  Future<void> _init() async {
    await signalRService.connect();

    signalRService.listenReservationExpired((data) {
      if (_isLoadingVisible && Navigator.canPop(navigatorKey.currentContext!)) {
        Navigator.of(navigatorKey.currentContext!).pop();
        _isLoadingVisible = false;
      }

      if (data.status == "failed" || data.status == "cancelled") {
        showGlobalOrderCancelledDialog(data.message);
      } else if (data.status == "success") {
        showGlobalOrderSuccessDialog(data.message);
      }

      emit(
        state.copyWith(
          lastMessage: data.message,
          orderId: data.orderId,
          status: data.status,
        ),
      );

      onPaymentMessage?.call(data);
    });
  }

  Future<void> startPaymentSession() async {
    if (!_isLoadingVisible) {
      _isLoadingVisible = true;
      showLoadingDialog();
    }

    await signalRService.connect();
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
