import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_event.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_state.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'category_bottom_sheet.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  String selectedCategory = 'All';

  void _openCategorySheet(BuildContext context, List categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: CategoryBottomSheet(
            selectedCategory: selectedCategory,
            categories: categories,
            onCategorySelected: (categoryName, categoryId) {
              setState(
                () => selectedCategory = categoryName,
              ); // ممكن الغيها كنت بجرب حاجة

              if (categoryId == 'all') {
                context.read<ProductsBloc>().add(const LoadProducts());
              } else {
                context.read<ProductsBloc>().add(
                  LoadProductsByCategoryId(categoryId),
                );
              }

              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return ElevatedButton(
            onPressed: null,
            child: const Text('Loading...'),
          );
        } else if (state is CategoryLoaded) {
          return ElevatedButton(
            onPressed: () => _openCategorySheet(context, state.categories),
            // child: Text(selectedCategory),
            child: Text("Category"),
          );
        } else if (state is CategoryError) {
          return ElevatedButton(
            onPressed: () => context.read<CategoryBloc>().add(LoadCategories()),
            child: const Text('Retry Categories'),
          );
        } else {
          return ElevatedButton(
            onPressed: () => context.read<CategoryBloc>().add(LoadCategories()),
            child: const Text('Category'),
          );
        }
      },
    );
  }
}
