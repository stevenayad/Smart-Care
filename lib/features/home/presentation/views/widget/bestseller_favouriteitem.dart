import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/best_seller_model/item.dart';

class BestsellerFavouriteitem extends StatelessWidget {
  const BestsellerFavouriteitem({super.key, required this.model});
  final BestSellerItem model;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              model.mainImageUrl ?? "",
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            model.nameEn ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '⭐ ${model.averageRating}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.orange),
          ),

          const SizedBox(height: 4),
          Text(
            '\$${model.price}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
