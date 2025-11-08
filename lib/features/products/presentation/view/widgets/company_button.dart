import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import '../../bloc/companies/companies_bloc.dart';
import '../../bloc/companies/companies_event.dart';
import '../../bloc/companies/companies_state.dart';
import '../../bloc/products/products_bloc.dart';
import 'company_bottom_sheet.dart';

class CompanyButton extends StatefulWidget {
  const CompanyButton({super.key});

  @override
  State<CompanyButton> createState() => _CompanyButtonState();
}

class _CompanyButtonState extends State<CompanyButton> {
  String selectedCompany = 'All';

  void _openCompanySheet(BuildContext context, List companies) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: CompanyBottomSheet(
            selectedCompany: selectedCompany,
            companies: companies,
            onCompanySelected: (companyName, companyId) {
              setState(() => selectedCompany = companyName);// ممكن تتلغة كنت بجرب 

              if (companyId == 'all') {
                context.read<ProductsBloc>().add(const LoadProducts());
              } else {
                context.read<ProductsBloc>().add(
                  LoadProductsByCompany(companyId),
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
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        if (state is CompaniesLoading) {
          return ElevatedButton(
            onPressed: null,
            child: const Text('Loading...'),
          );
        } else if (state is CompaniesLoaded) {
          return ElevatedButton(
            onPressed: () => _openCompanySheet(context, state.companies),
            // child: Text(selectedCompany),
            child: Text("Company"),
          );
        } else if (state is CompaniesError) {
          return ElevatedButton(
            onPressed: () => context.read<CompaniesBloc>().add(LoadCompanies()),
            child: const Text('Retry Companies'),
          );
        } else {
          return ElevatedButton(
            onPressed: () => context.read<CompaniesBloc>().add(LoadCompanies()),
            child: const Text('Company'),
          );
        }
      },
    );
  }
}
