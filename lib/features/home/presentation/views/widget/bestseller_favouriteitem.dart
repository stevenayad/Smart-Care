import 'package:flutter/material.dart';

class BestsellerFavouriteitem extends StatelessWidget {
  const BestsellerFavouriteitem({super.key});
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
              'https://images.pexels.com/photos/3683079/pexels-photo-3683079.jpeg',
              height:
                  100, //need give height , because not take original height  of screen
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vitamin C 1000mg',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '⭐ 4.8',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.orange),
          ),

          const SizedBox(height: 4),
          Text(
            '\$15.99',
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
