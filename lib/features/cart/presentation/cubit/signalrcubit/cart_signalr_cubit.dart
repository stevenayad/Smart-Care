import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/core/widget/show_dailog_cart.dart';
import '../cart/cart_cubit.dart';
import 'cart_signalr_state.dart';

class CartSignalRCubit extends Cubit<CartSignalRState> {
  final AppSignalRService signalRService;
  final CartCubit cartCubit;

  Function(String message)? onReservationMessage;

  CartSignalRCubit({required this.signalRService, required this.cartCubit})
    : super(CartSignalRState()) {
    _addListener();
  }

  void _addListener() {
    signalRService.onCartReservationExpired = (data) async {
      if (isClosed || cartCubit.isClosed) return;
      showGlobalCartCancelledDialog(data.message ?? "");

      cartCubit.cartItems.removeWhere((i) => i.productId == data.productId);

      if (cartCubit.cartId != null && !cartCubit.isClosed) {
        await cartCubit.GetITem(cartCubit.cartId!);
      }

      emit(
        state.copyWith(
          lastMessage: data.message,
          items: [...cartCubit.cartItems],
        ),
      );

      onReservationMessage?.call(data.message ?? "");
    };
  }

  @override
  Future<void> close() async {
    // Don't close the connection here; it's shared app-wide
    return super.close();
  }
}
