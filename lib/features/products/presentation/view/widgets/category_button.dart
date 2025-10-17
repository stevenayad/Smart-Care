import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/category_bottom_sheet.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  String selectedCategory = "All";
  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CategoryBottomSheet(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: "Category",
      icon: Icons.category,
      isFullWidth: false,
      
      onPressed: _showCategoryBottomSheet,
    );
  }
}
