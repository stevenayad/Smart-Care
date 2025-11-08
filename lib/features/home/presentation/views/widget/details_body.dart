import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/detailsproduct/detailsproduct_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/image_details.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_details.dart';
import 'package:smartcare/features/home/presentation/views/widget/check_store.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsproductCubit, DetailsproductState>(
      builder: (context, state) {
        if (state is DetailsproductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailsproductFaliure) {
          return Center(child: Text("❌ ${state.errMesssage}"));
        } else if (state is DetailsproductSuccess) {
          final product = state.detialsProductModel;
          return SingleChildScrollView(
            child: Column(
              children: [
                ImageDetails(detialsProductModel: product),
                ProductDetails(detialsProductModel: product),
                CheckStore(),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
