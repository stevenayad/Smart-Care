import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/data/model/add_item_cart_model/add_item_cart_model.dart';
import 'package:smartcare/features/cart/data/model/add_item_cart_model/data.dart';
import 'package:smartcare/features/cart/data/model/create_cart_model.dart';
import 'package:smartcare/features/cart/data/model/items_cart/datum.dart';
import 'package:smartcare/features/cart/data/model/items_cart/items_cart.dart';
import 'package:smartcare/features/cart/data/model/remove_item_cart_model.dart';
import 'package:smartcare/features/cart/data/model/request_add_item_model.dart';
import 'package:smartcare/features/cart/data/model/request_remove_item.dart';
import 'package:smartcare/features/cart/data/model/request_update_item_model.dart';
import 'package:smartcare/features/cart/data/model/update_cart_item_model/data.dart';
import 'package:smartcare/features/cart/data/model/update_cart_item_model/update_cart_item_model.dart';
import 'package:smartcare/features/cart/presentation/cubit/signalrcubit/cart_signalr_state.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Cartrepo cartrepo;
  final CartSignalRService signalRService;

  CartCubit({required this.cartrepo, required this.signalRService})
      : super(CartInitial()) {
    makecart();
  }

  String? cartId;

  List<DatumCart> _cartItems = [];
  List<DatumCart> get cartItems => _cartItems;

  void setCartItems(List<DatumCart> items) {
    _cartItems = items;
    emit(GetItemSucces(itemsCart: ItemsCart(data: _cartItems)));
  }

  Future<void> makecart() async {
    emit(CartInitial());
    final result = await cartrepo.createcart();
    result.fold(
      (failure) => emit(CartFailure(errmessage: failure.errMessage)),
      (model) async {
        cartId = model.data;
        if (cartId != null) {
          await signalRService.joinUserGroup(cartId!);
        }
        emit(CartSucces(createCartModel: model));
        await GetITem(cartId!);
      },
    );
  }

  Future<void> PutItem(RequestAddItemModel request) async {
    emit(CartInitial());
    final result = await cartrepo.AddItem(request);
    result.fold(
      (failure) => emit(CartFailure(errmessage: failure.errMessage)),
      (model) {
        final newItem = model.data;
        if (newItem != null) {
          _cartItems = [..._cartItems, mapAddDataToDatumCart(newItem)];
        }
        emit(AddItemSucces(addItemSucces: model));
      },
    );
  }

  Future<void> DeleteItem(RequestRemoveItem request) async {
    emit(CartInitial());
    final result = await cartrepo.RemoveItem(request);
    result.fold(
      (failure) => emit(CartFailure(errmessage: failure.errMessage)),
      (model) {
        _cartItems = _cartItems.where((e) => e.id != request.cartItemId).toList();
        emit(RemoveItemSucces(removeItemCartModel: model));
      },
    );
  }

  Future<void> GetITem(String Cartid) async {
    emit(CartInitial());
    final result = await cartrepo.GetItemCart(Cartid);
    result.fold(
      (failure) => emit(CartFailure(errmessage: failure.errMessage)),
      (model) {
        _cartItems = List<DatumCart>.from(model.data ?? []);
        emit(GetItemSucces(itemsCart: model));
      },
    );
  }

  Future<void> UpdateItem(RequestUpdateItemModel request) async {
    emit(CartLoading());
    final result = await cartrepo.UpdateItemCart(request);
    result.fold(
      (failure) => emit(CartFailure(errmessage: failure.errMessage)),
      (model) {
        final updated = model.data;
        if (updated != null) {
          final index = _cartItems.indexWhere((e) => e.id == updated.id);
          if (index != -1) {
            _cartItems[index] = mapUpdateDataToDatumCart(updated);
          }
        }
        emit(UpdateItemSucces(updateCartItemModel: model));
      },
    );
  }
}
