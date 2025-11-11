import 'package:flutter/material.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/datum.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/favorite_item_model.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/image_favourite.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({super.key, required this.favouriteItem});

  final FavDatum favouriteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ImageFavourite(favouriteItem: favouriteItem)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favouriteItem.productNameEn ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      favouriteItem.totalRatings.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${favouriteItem.price.toString()} Egy ',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
