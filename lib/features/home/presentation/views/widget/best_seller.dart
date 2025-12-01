import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/cubit/best_seller_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/bestseller_favouriteitem.dart';
import 'package:smartcare/features/home/presentation/views/widget/common_section.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is BestSellerSuccess) {
          final items = state.bestSellerModel.data!.items ?? [];

          return BestSellerSection(
            title: 'Best Sellers',
            items: items
                .map((item) => BestsellerFavouriteitem(model: item))
                .toList(),
          );
        }

        return const SizedBox();
      },
    );
  }
}
