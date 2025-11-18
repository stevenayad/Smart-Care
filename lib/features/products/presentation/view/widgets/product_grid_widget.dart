import 'package:flutter/material.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';
import 'animated_product_item.dart'; 

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
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        
        return AnimatedProductItem(product: product);
      },
    );
  }
}