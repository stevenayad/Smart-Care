import 'package:flutter/material.dart';
import 'package:smartcare/features/Favourite/data/Models/favourite_item_model.dart';

class ImageFavourite extends StatelessWidget {
  const ImageFavourite({super.key, required this.favouriteItemModel});
  final FavouriteItemModel favouriteItemModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            favouriteItemModel.image,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 140,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 60,
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
