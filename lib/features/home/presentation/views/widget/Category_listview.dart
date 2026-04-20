import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/category_list_view.dart';

@Deprecated('Use presentation/components/category/category_list_view.dart')
class CategoryListview extends StatelessWidget {
  const CategoryListview({
    super.key,
    required Function(String) onCategoryoSelected,
    String? selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return const CategoryListView();
  }
}
