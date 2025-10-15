import 'package:flutter/material.dart';
import 'package:smartcare/features/products/presentation/view/widgets/category_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/company_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/dropdown_list_widget.dart';

class ChiocesRow extends StatelessWidget {
  const ChiocesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryButton(),
          SizedBox(width: 10),
          CompanyButton(),
          SizedBox(width: 10),
          DropdownListWidget(),
        ],
      ),
    );
  }
}
