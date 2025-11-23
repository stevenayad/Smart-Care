import 'package:flutter/material.dart';
import 'package:smartcare/features/check%20availability/check_availability_screen.dart'
    show CheckAvailabilityScreen;
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';
import 'package:smartcare/features/home/presentation/views/widget/build_info_section.dart';
import 'package:smartcare/features/home/presentation/views/widget/check_store.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_price.dart';

import 'package:smartcare/features/home/presentation/views/widget/rate_view.dart';

class ProductDetails extends StatelessWidget {
  final DetailsProductModel detialsProductModel;
  const ProductDetails({super.key, required this.detialsProductModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              Text(
                detialsProductModel.data?.nameEn ?? " ",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Company Info & Rating
              buildInfoSection(detialsProductModel),
              const SizedBox(height: 12),

              // Rate Review
              RateReview(detailsProductModel: detialsProductModel),
              const SizedBox(height: 12),

              // Price & Description
              ProductPrice_Descrption_Section(
                detailsProductModel: detialsProductModel,
              ),
              const SizedBox(height: 20),

              // Check Availability Button
              ActionButton(
                title: "Check Availability in Store",
                icon: Icons.location_on,
                backgroundColor: Colors.yellow.shade200,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckAvailabilityScreen(productId: detialsProductModel.data!.productId!,),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Add to Cart Button
              ActionButton(
                title: "Add to Cart",
                icon: Icons.shopping_cart,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
