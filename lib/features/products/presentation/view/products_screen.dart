import 'package:flutter/material.dart';
import 'package:smartcare/features/products/presentation/view/widgets/app_bar.dart';
import 'package:smartcare/features/products/presentation/view/widgets/chioces_row.dart';
import 'package:smartcare/features/products/presentation/view/widgets/product_grid_widget.dart';
import 'package:smartcare/features/products/presentation/view/widgets/search_bar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarr(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(),
              const SizedBox(height: 20),
              ChiocesRow(),
              const SizedBox(height: 20),
              ProductGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
