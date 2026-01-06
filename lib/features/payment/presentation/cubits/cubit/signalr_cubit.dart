import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/show_dailog_payment.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/features/payment/presentation/cubits/cubit/signalr_state.dart';
import 'package:smartcare/main.dart';

class PaymentSignalRCubit extends Cubit<PaymentSignalRState> {
  final AppSignalRService signalRService;

  Function(OrderResponse model)? onPaymentMessage;
  bool _isLoadingVisible = false;

  PaymentSignalRCubit({required this.signalRService})
    : super(PaymentSignalRState()) {
    _addListener();
  }

  void _addListener() {
    signalRService.onPaymentStatusChanged = (data) {
      if (_isLoadingVisible && Navigator.canPop(navigatorKey.currentContext!)) {
        Navigator.of(navigatorKey.currentContext!).pop();
        _isLoadingVisible = false;
      }

      if (data.status == "failed" || data.status == "cancelled") {
        showGlobalPaymntCancelledDialog(data.message);
      } else if (data.status == "success") {
        showGlobalPaymentSuccessDialog(data.message);
      }

      emit(
        state.copyWith(
          lastMessage: data.message,
          orderId: data.orderId,
          status: data.status,
        ),
      );

      onPaymentMessage?.call(data);
    };
  }

  Future<void> startPaymentSession() async {
    if (!_isLoadingVisible) {
      _isLoadingVisible = true;
      showLoadingDialog();
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
