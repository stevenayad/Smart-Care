import 'package:flutter/material.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';

class CategoryBottomSheet extends StatelessWidget {
  final String selectedCategory;
  final List<dynamic> categories;
  final void Function(String categoryName, String categoryId) onCategorySelected;

  const CategoryBottomSheet({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final allCategories = [
      CategoryModel(id: 'all', name: 'All', productsCount: 0, logoUrl: ''),
      ...categories,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Text(
            'Select Category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: allCategories.length,
              itemBuilder: (context, index) {
                final c = allCategories[index];
                final isSelected = selectedCategory == c.name;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onCategorySelected(c.name, c.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blueGrey[300]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          if (c.logoUrl.isNotEmpty)
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(c.logoUrl),
                            )
                          else
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.category, color: Colors.white),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              c.name,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (c.productsCount > 0)
                            Text(
                              '${c.productsCount}',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
