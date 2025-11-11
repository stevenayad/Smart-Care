import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/Favourite/presentation/cubits/favourite/favoutie_cubit.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/favourite_item_list.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          BlocBuilder<DisplayFavoutieCubit, DisplayFavoutieState>(
            builder: (context, state) {
              if (state is FavoutieSuceesss) {
                final lengthsitems = state.favoriteItemModel.data?.length ?? 0;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$lengthsitems Item Saved',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 24,
                        color: Colors.blueAccent.shade200,
                      ),
                    ),
                  ),
                );
              } else if (state is FavoutieLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is FavoutieFaliuree) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Error: ${state.errmessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
            },
          ),

          const FavouriteItemList(),
        ],
      ),
    );
  }
}
