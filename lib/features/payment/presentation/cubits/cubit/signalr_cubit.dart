import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/show_dailog_cancel_order.dart';
import 'package:smartcare/features/payment/data/repo/payment_signalr.dart';
import 'package:smartcare/features/payment/presentation/cubits/cubit/signalr_state.dart';
import 'package:smartcare/main.dart';

class PaymentSignalRCubit extends Cubit<PaymentSignalRState> {
  final PaymentSignalr signalRService;

  Function(OrderResponse model)? onPaymentMessage;

  StreamSubscription? _paymentStream;

  PaymentSignalRCubit({required this.signalRService})
    : super(PaymentSignalRState()) {
    _init();
  }

  Future<void> _init() async {
    await signalRService.connect();

    signalRService.listenReservationExpired((data) {
      if (data.status == "failed" || data.status == "cancelled") {
        navigatorKey.currentState?.pop();
        showGlobalOrderCancelledDialog(data.message);
      } else if (data.status == "success") {
        showGlobalOrderSuccessDialog(data.message);
      }
      final orderId = data.orderId;
      final status = data.status;
      final message = data.message;

      emit(
        state.copyWith(lastMessage: message, orderId: orderId, status: status),
      );

      onPaymentMessage?.call(data);
    });
  }

  /*Future<void> joinUserGroup() async {
    await signalRService.joinUserGroup();
    print('Join in Payment ');
  }*/

  @override
  Future<void> close() async {
    await _paymentStream?.cancel();
    return super.close();
  }
}
