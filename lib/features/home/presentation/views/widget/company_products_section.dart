import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/data/Model/productforcompany/item.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';
import 'package:smartcare/features/home/presentation/views/widget/pagination_controls.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_details.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_grid_view.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_item.dart';

class CompanyProductsSection extends StatelessWidget {
  const CompanyProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        final cubit = context.read<CompanyCubit>();

        if (state is Companyloading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is Companyfaliure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is ProductCompanySuccess) {
          final List<ProductItemModel> products =
              state.productforcompany.data?.items ?? <ProductItemModel>[];
          final totalPages = state.productforcompany.data?.totalPages ?? 1;

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
                      rating: product.averageRating,
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
            'Select a company to view products',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}
