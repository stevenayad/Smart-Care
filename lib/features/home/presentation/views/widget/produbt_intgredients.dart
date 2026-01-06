import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';

class ProductIngredients extends StatelessWidget {
  final DetailsProductModel detailsProductModel;

  const ProductIngredients({super.key, required this.detailsProductModel});

  @override
  Widget build(BuildContext context) {
    final List<String> ingredients =
        detailsProductModel.data!.activeIngredients!.isEmpty
        ? []
        : detailsProductModel.data!.activeIngredients!.split(',');

    if (ingredients.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ingredients",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ingredients.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(child: Text(e.trim())),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
