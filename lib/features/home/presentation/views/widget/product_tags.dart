import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';

class ProductTags extends StatelessWidget {
  final DetailsProductModel detailsProductModel;

  const ProductTags({super.key, required this.detailsProductModel});

  @override
  Widget build(BuildContext context) {
    
    final String tagsString = detailsProductModel.data?.tags ?? "";
    final List<String> tags = tagsString.isEmpty
        ? []
        : tagsString.split(',').map((e) => e.trim()).toList();

    if (tags.isEmpty) return const SizedBox();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}
