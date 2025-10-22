import 'package:flutter/material.dart';
import 'package:smartcare/features/Favourite/data/Models/favourite_item_model.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/favourite_item.dart';

class FavouriteItemList extends StatelessWidget {
  const FavouriteItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteItems = [
      FavouriteItemModel(
        image:
            'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=500',
        name: 'Luxury Perfume',
        rate: '4.8',
        price: '\$120',
      ),
      FavouriteItemModel(
        image:
            'https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=500',
        name: 'Matte Lipstick',
        rate: '4.6',
        price: '\$25',
      ),
      FavouriteItemModel(
        image:
            'https://images.unsplash.com/photo-1606813902912-6c2256f7be2f?w=500',
        name: 'Face Moisturizer',
        rate: '4.9',
        price: '\$45',
      ),
      FavouriteItemModel(
        image:
            'https://images.unsplash.com/photo-1519741497674-611481863552?w=500',
        name: 'Smart Watch',
        rate: '4.7',
        price: '\$199',
      ),
      FavouriteItemModel(
        image:
            'https://images.unsplash.com/photo-1519744346363-dc63f32034a2?w=500',
        name: 'Running Shoes',
        rate: '4.5',
        price: '\$89',
      ),
    ];

    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return FavouriteItem(favouriteItemModel: favouriteItems[index]);
      }, childCount: favouriteItems.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
    );
  }
}
