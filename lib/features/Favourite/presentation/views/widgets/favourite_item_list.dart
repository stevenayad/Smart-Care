import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/Favourite/presentation/cubits/favourite/favoutie_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';
import 'favourite_item.dart';

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

          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailsScreen(Productid: items[index].productId!),
                      ),
                    );
                  },
                  child: FavouriteItem(favouriteItem: items[index])),
                childCount: items.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
