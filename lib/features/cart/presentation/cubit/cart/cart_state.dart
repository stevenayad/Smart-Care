part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartSucces extends CartState {
  final CreateCartModel createCartModel;

  CartSucces({required this.createCartModel});
}

class AddItemSucces extends CartState {
  final AddItemCartModel addItemSucces;

  AddItemSucces({required this.addItemSucces});
}

class RemoveItemSucces extends CartState {
  final RemoveItemCartModel removeItemCartModel;

  RemoveItemSucces({required this.removeItemCartModel});
}

class UpdateItemSucces extends CartState {
  final UpdateCartItemModel updateCartItemModel;

  UpdateItemSucces({required this.updateCartItemModel});
}

class GetItemSucces extends CartState {
  final ItemsCart itemsCart;

  GetItemSucces({required this.itemsCart});
}

class CartFailure extends CartState {
  final String errmessage;

  CartFailure({required this.errmessage});
}

class CartLoading extends CartState {}
