import 'package:equatable/equatable.dart';
import 'package:smartcare/features/cart/data/model/items_cart/datum.dart';


class CartSignalRState extends Equatable {
  final String? lastMessage;
  final List<DatumCart> items;

  CartSignalRState({this.lastMessage, this.items = const []});

  CartSignalRState copyWith({String? lastMessage, List<DatumCart>? items}) {
    return CartSignalRState(
      lastMessage: lastMessage ?? this.lastMessage,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [lastMessage, items];
}
