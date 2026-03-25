import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';
import 'package:smartcare/features/profile/presentation/Cubits/simillar/simillarproduct_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/simillar/simillarproduct_state.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Similar Products",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),

        BlocBuilder<SimilarProductsCubit, SimilarProductsState>(
          builder: (context, state) {
            if (state is SimilarProductsLoading) {
              return buildCompanyShimmerList();
            }

            if (state is SimilarProductsFailure) {
              return Text(state.error);
            }

            if (state is SimilarProductsSuccess) {
              final products = state.products;

              return SizedBox(
                height: 172,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(Productid: product.productId!),
                          ),
                        );
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF7F9FC), Color(0xFFE3F2FD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// product image + availability
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.mainImageUrl ?? "",
                                    height: 90,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                /// availability icon
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: product.isAvailable == true
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      product.isAvailable == true
                                          ? Icons.check
                                          : Icons.close,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            /// name
                            Text(
                              product.nameEn ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),

                            const Spacer(),

                            /// price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${product.price} EGP",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                /// check icon
                                if (product.isAvailable == true)
                                  const Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
