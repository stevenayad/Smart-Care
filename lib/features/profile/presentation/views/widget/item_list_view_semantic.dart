import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';
import 'package:smartcare/features/profile/presentation/Cubits/semanticsearch/semanticsearch_cubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/item_card_semantic.dart';

class ItemListViewSemantic extends StatelessWidget {
  const ItemListViewSemantic();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SemanticsearchCubit, SemanticsearchState>(
      builder: (context, state) {
        if (state is Semanticsearchloading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SemanticsearchSuccess) {
          final items = state.semanticModel.data;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(Productid: item.productId!),
                    ),
                  );
                },
                child: ItemCardSemantic(item: item),
              );
            },
          );
        }
        if (state is SemanticsearchFailure) {
          return Center(child: Text(state.errMessage));
        }
        return Center(child: Text("Search something"));
      },
    );
  }
}
