import 'package:flutter/material.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';
import 'package:smartcare/features/products/presentation/view/widgets/product_item.dart';

class ProductGridWidget extends StatelessWidget {
  final List<ProductModel> products;
  const ProductGridWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found.'));
    }
    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        final p = products[index];
        return ProductItem(
          imageUrl: p.primaryImageUrl,
          title: p.nameEn,
          brand: p.activeIngredients,
          rating: p.averageRating,
          price: p.price,
          onAdd: () {},
          onFavorite: () {},
        );
      },
    );
  }
}
