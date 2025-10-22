import 'package:flutter/material.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/favourite_item_list.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '5 Item Saved',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 24,
                  color: Colors.blueAccent.shade200,
                ),
              ),
            ),
          ),

          const FavouriteItemList(),
        ],
      ),
    );
  }
}
