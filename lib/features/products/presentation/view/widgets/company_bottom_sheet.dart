import 'package:flutter/material.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/custom_bottom_sheet.dart';

class CompanyBottomSheet extends StatelessWidget {
  final String selectedCompany;
  final ValueChanged<String> onCompanySelected;

  const CompanyBottomSheet({
    super.key,
    required this.selectedCompany,
    required this.onCompanySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'HealthCO',
      'PharmaTech',
      'Medicare',
      'CleanCo',
      'BabySafe',
    ];

    return CustomBottomSheet(
      title: "Select Company",
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category == selectedCompany;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  onCompanySelected(category);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blueGrey[300]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
