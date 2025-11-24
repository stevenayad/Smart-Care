import 'package:dartz/dartz.dart' as product show id;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/cart/data/model/request_add_item_model.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
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

              buildInfoSection(detialsProductModel),
              const SizedBox(height: 12),

              RateReview(detailsProductModel: detialsProductModel),
              const SizedBox(height: 12),

              ProductPrice_Descrption_Section(
                detailsProductModel: detialsProductModel,
              ),
              const SizedBox(height: 20),

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

              BlocListener<CartCubit, CartState>(
                listener: (context, state) {
                  if (state is CartFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errmessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  if (state is AddItemSucces) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product added to cart"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: ActionButton(
                  title: "Add to Cart",
                  icon: Icons.shopping_cart,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    final cubit = context.read<CartCubit>();
                    final cartId = cubit.cartId ?? '';

                    cubit.PutItem(
                      RequestAddItemModel(
                        cartId: cartId,
                        productId: detialsProductModel.data?.productId,
                        quantity: 1,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
