import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_event.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_state.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/gradient_button.dart';
import 'category_bottom_sheet.dart';

class CategoryButton extends StatefulWidget {
  final VoidCallback onResetPage;
  const CategoryButton({super.key, required this.onResetPage});

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
                widget.onResetPage();
                context.read<ProductsBloc>().add(const LoadProducts());
              } else {
                context.read<ProductsBloc>().add(
                  LoadProductsByCategoryId(categoryId, 1, 10),
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
          return SmallGradientButton(text: "Loading...", onTap: null);
        } else if (state is CategoryLoaded) {
          return SmallGradientButton(
            text: "Category",
            onTap: () => _openCategorySheet(context, state.categories),
          );
        } else if (state is CategoryError) {
          return SmallGradientButton(
            text: "Retry Categories",
            onTap: () => context.read<CategoryBloc>().add(LoadCategories()),
          );
        } else {
          return SmallGradientButton(
            text: 'Category',
            onTap: () {
              context.read<CategoryBloc>().add(LoadCategories());
            },
          );
        }
      },
    );
  }
}
