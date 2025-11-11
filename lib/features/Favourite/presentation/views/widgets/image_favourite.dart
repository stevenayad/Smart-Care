import 'package:flutter/material.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/datum.dart';

class ImageFavourite extends StatelessWidget {
  const ImageFavourite({super.key, required this.favouriteItem});
  final FavDatum favouriteItem;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            favouriteItem.mainImageUrl ??
                'https://th.bing.com/th/id/R.9069ae2c83237354d556ac82e37c8066?rik=wVvlGFIhBYX5bg&riu=http%3a%2f%2fwww.pixelstalk.net%2fwp-content%2fuploads%2f2016%2f06%2fHD-images-of-nature-download.jpg&ehk=J7hY3CfwcsW7lTkuGbE3nQPUYPdt1OTluYfKHRW62qs%3d&risl=&pid=ImgRaw&r=0',
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
