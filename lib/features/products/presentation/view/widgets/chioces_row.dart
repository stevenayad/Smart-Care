import 'package:flutter/material.dart';
import 'package:smartcare/features/products/presentation/view/widgets/FilterButton/filter_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/category_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/company_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/dropdown_list_widget.dart';

class ChiocesRow extends StatelessWidget {
  final VoidCallback onResetPage;
  const ChiocesRow({super.key, required this.onResetPage});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryButton(onResetPage: onResetPage),
          SizedBox(width: 10),
          CompanyButton(onResetPage: onResetPage),
          SizedBox(width: 10),
          // DropdownListWidget(),
          FilterButton(),
        ],
      ),
    );
  }
}
