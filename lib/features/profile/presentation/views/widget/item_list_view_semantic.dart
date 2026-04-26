import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';
import 'package:smartcare/features/profile/data/Model/semantic_model/datum.dart'
    show SemanticDatum;
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
            itemCount: items!.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCardSemantic(item: item);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
          );
        }

        if (state is VoiceSemanticsearchSuccess) {
          final items = state.voiceSemanticSearch;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              // Map VoiceSemanticDatum to SemanticDatum to match ItemCardSemantic's expected type
              return ItemCardSemantic(
                item: SemanticDatum(
                  productId: item.productId,
                  nameEn: item.nameEn,
                  mainImageUrl: item.mainImageUrl,
                  price: item.price?.toDouble(),
                  averageRating: item.averageRating?.toDouble(),
                  isAvailable: item.isAvailable,
                  discountPercentage: item.discountPercentage,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
          );
        }
        if (state is SemanticsearchFailure) {
          return Center(child: Text(state.errMessage));
        }
        if (state is VoiceSemanticsearchFailure) {
          return Center(child: Text(state.errMessage));
        }
        return Center(child: Text("Search something"));
      },
    );
  }
}
