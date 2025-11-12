import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_price.dart';
import 'package:smartcare/features/home/presentation/views/widget/rate&review.dart';
import 'package:smartcare/features/home/presentation/views/widget/rate_view.dart';

class ProductDetails extends StatelessWidget {
  final DetailsProductModel detialsProductModel;
  const ProductDetails({super.key, required this.detialsProductModel});

  @override
  Widget build(BuildContext context) {
    print('(((((((((((((((((((((9(((((9999))))))))))))))))))))))))))');
    print(detialsProductModel.data?.nameEn);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  detialsProductModel.data?.nameEn ?? " ",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            detialsProductModel.data?.companyName ?? " ",
            style: const TextStyle(fontSize: 14, color: Color(0xFF78909C)),
          ),
          const SizedBox(height: 10),
          Rate(detialsProductModel: detialsProductModel),
          const SizedBox(height: 12),
          Ratereview(detialsProductModel: detialsProductModel),
          const SizedBox(height: 20),
          ProductPrice(detialsProductModel: detialsProductModel),
          const SizedBox(height: 30),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Color(0xFFE0E0E0)),
          Text(
            detialsProductModel.data?.description ?? " ",
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
