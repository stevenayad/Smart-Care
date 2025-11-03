import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/shimer_box.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/common_section.dart';
import 'package:smartcare/features/home/presentation/views/widget/gategory_brandsitem.dart';

class PopularBrand extends StatelessWidget {
  const PopularBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        if (state is Companyloading) {
          return CommonSection(
            isbestseller_favourotiteite: false,
            title: "Company",
            onViewAllTap: () {},
            items: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    shimmerBox(height: 60, width: 60, radius: 12),
                    const SizedBox(height: 8),
                    shimmerBox(height: 12, width: 50, radius: 6),
                  ],
                ),
              ),
            ),
          );
          ;
        } else if (state is Companyfaliure) {
          return Center(
            child: Text(
              "❌ ${state.errMessage}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is CompanySuccess) {
          final companies = state.companyModel.data ?? [];
          if (companies.isEmpty) {
            return const Center(child: Text("No companies found"));
          }
          return CommonSection(
            isbestseller_favourotiteite: false,
            title: "Company",
            onViewAllTap: () {},
            items: companies
                .map(
                  (company) => GategoryBrandsitem(
                    image: company.logoUrl ?? "assets/image/bayer.png",
                    text: company.name ?? "Unknown",
                  ),
                )
                .toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
