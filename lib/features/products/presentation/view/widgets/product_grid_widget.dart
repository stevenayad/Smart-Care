import 'package:flutter/material.dart';
import 'product_item.dart'; // Import the widget above

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data (will be replaced by API later)
    final products = List.generate(
      8,
      (index) => {
        "image": "assets/image/OIP.webp",
        "title": "Vitamin C 1000mg",
        "brand": "HealthCo",
        "rating": 4.8,
        "price": 15.99,
      },
    );

    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 0.4,
      ),
      itemBuilder: (context, index) {
        final p = products[index];
        return ProductItem(
          imageUrl: p["image"] as String,
          title: p["title"] as String,
          brand: p["brand"] as String,
          rating: p["rating"] as double,
          price: p["price"] as double,
          onAdd: () {},
          onFavorite: () {},
        );
      },
    );
  }
}
