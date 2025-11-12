import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/favorite_item_model.dart';
import 'package:smartcare/features/Favourite/presentation/cubits/favourite/favoutie_cubit.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/favourite_item.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';

class FavouriteItemList extends StatelessWidget {
  const FavouriteItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFavoutieCubit, DisplayFavoutieState>(
      builder: (context, state) {
        if (state is Favouriteloading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is FavoutieFaliuree) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${state.errmessage}')),
          );
        } else if (state is FavoutieSuceesss) {
          final items = state.favoriteItemModel.data;

          if (items!.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text('No Favourite Yet')),
            );
          }
          return SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final fav = items[index];
              return FavouriteItem(favouriteItem: fav);
            }, childCount: items.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
