import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/cart/data/model/items_cart/datum.dart';
import 'package:smartcare/features/cart/data/model/request_remove_item.dart';
import 'package:smartcare/features/cart/data/model/request_update_item_model.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'action_button.dart';

class Cartitem extends StatelessWidget {
  final DatumCart item;

  const Cartitem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final cartId = cubit.cartId!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.mainImageUrl ?? "",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ActionButtonCart(
                          iconData: Icons.remove,
                          onPressed: () {
                            if (item.quantity! > 1) {
                              cubit.UpdateItem(
                                RequestUpdateItemModel(
                                  cartId: cartId,
                                  cartItemId: item.id,
                                  productId: item.productId,
                                  newQuantity: item.quantity! - 1,
                                ),
                              ).then((_) => cubit.GetITem(cartId));
                            } else {
                              cubit.DeleteItem(
                                RequestRemoveItem(
                                  cartId: cartId,
                                  cartItemId: item.id!,
                                ),
                              ).then((_) => cubit.GetITem(cartId));
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ActionButtonCart(
                          iconData: Icons.add,
                          onPressed: () {
                            cubit.UpdateItem(
                              RequestUpdateItemModel(
                                cartId: cartId,
                                cartItemId: item.id,
                                productId: item.productId,
                                newQuantity: item.quantity! + 1,
                              ),
                            ).then((_) => cubit.GetITem(cartId));
                          },
                        ),
                      ],
                    ),
                    Text(
                      "\$${item.totalPrice ?? item.unitPrice ?? 0}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
