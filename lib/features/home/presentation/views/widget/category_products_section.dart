import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/data/Model/productfor_gategory/item.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';
import 'package:smartcare/features/home/presentation/views/widget/pagination_controls.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_grid_view.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_item.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';

class CategoryProductsSection extends StatelessWidget {
  const CategoryProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatergoryCubit, GatergoryState>(
      builder: (context, state) {
        final cubit = context.read<CatergoryCubit>();

        if (state is GatergroyLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GatergroyFaliure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is GategoryCompanySuccess) {
          final List<Item> products =
              state.productforcategory.data?.items ?? <Item>[];
          final totalPages = state.productforcategory.data?.totalPages ?? 1;

          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return Column(
            children: [
              Expanded(
                child: ProductGridView(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItem(
                      title: product.nameEn ?? 'Unnamed',
                      subtitle: product.description,
                      imageUrl: product.mainImageUrl,
                      price: product.price ?? 0,
                      rating: (product.averageRating ?? 0).toDouble(),
                      isAvailable: product.isAvailable,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              Productid: product.productId ?? "",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              PaginationControls(
                currentPage: cubit.currentPage,
                totalPages: totalPages,
                onPrevious: cubit.currentPage > 1 ? cubit.previousPage : null,
                onNext: cubit.currentPage < totalPages ? cubit.nextPage : null,
              ),
            ],
          );
        }

        return const Center(
          child: Text(
            'Select a category to view products',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}
