import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/company_bottom_sheet.dart';

class CompanyButton extends StatefulWidget {
  const CompanyButton({super.key});

  @override
  State<CompanyButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CompanyButton> {
  String selectedCompany = "All";
  void _showCompanyBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CompanyBottomSheet(
            selectedCompany: selectedCompany,
            onCompanySelected: (company) {
              setState(() {
                selectedCompany = company;
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
      text: "Company",
      isFullWidth: false,
      onPressed: _showCompanyBottomSheet,
    );
  }
}
