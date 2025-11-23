import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/show_dailog_cancel_order.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import '../cart/cart_cubit.dart';
import 'cart_signalr_state.dart';

class CartSignalRCubit extends Cubit<CartSignalRState> {
  final CartSignalRService signalRService;
  final CartCubit cartCubit;

  Function(String message)? onReservationMessage;

  StreamSubscription? _cartStream;

  CartSignalRCubit({required this.signalRService, required this.cartCubit})
    : super(CartSignalRState()) {
    _init();
  }

  Future<void> _init() async {
    await signalRService.connect();

    signalRService.listenReservationExpired((data) async {
    
        showGlobalOrderCancelledDialog(data.message! );

      final id = data.productId;
      final msg = data.message ?? "";

      cartCubit.cartItems.removeWhere((i) => i.productId == id);

      if (cartCubit.cartId != null) {
        await cartCubit.GetITem(cartCubit.cartId!);
      }

      emit(state.copyWith(lastMessage: msg, items: [...cartCubit.cartItems]));

      onReservationMessage?.call(msg);
    });
  }

  @override
  Future<void> close() async {
    await _cartStream?.cancel();
    return super.close();
  }
}
