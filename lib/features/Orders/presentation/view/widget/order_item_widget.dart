import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/Orders/data/models/order_item_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        color: AppColors.primaryblue.withValues(alpha: 0.05),

        borderRadius: BorderRadius.circular(16),
        elevation: 0,

        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: -2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    image:
                        (product?.imageUrl != null &&
                            product!.imageUrl!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(product.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      (product?.imageUrl == null || product!.imageUrl!.isEmpty)
                      ? const Center(
                          child: Icon(
                            Icons.shopping_bag_rounded,
                            color: AppColors.mediumGrey,
                            size: 32,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.nameEn ?? "Unknown Product",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      if (product?.description != null &&
                          product!.description!.isNotEmpty)
                        Text(
                          product.description!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.mediumGrey.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 8),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Qty: ${item.quantity}",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.mediumGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(width: 12),

                          if (product?.discountPercentage != null &&
                              product!.discountPercentage! > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: .1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${product.discountPercentage!.toStringAsFixed(2)}% OFF",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // 3. Subtotal Price
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "\$${item.subTotal?.toStringAsFixed(2) ?? '0.00'}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryblue,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
