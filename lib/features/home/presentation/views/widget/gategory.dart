import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/shimer_box.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/common_section.dart';
import 'package:smartcare/features/home/presentation/views/widget/gategory_brandsitem.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatergoryCubit, GatergoryState>(
      builder: (context, state) {
        if (state is GatergroyLoading) {
        
          return CommonSection(
            isbestseller_favourotiteite: false,
            title: "Categories",
            onViewAllTap: () {},
            items: List.generate(
              6,
              (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shimmerBox(height: 60, width: 60, radius: 30),
                  const SizedBox(height: 8),
                  shimmerBox(width: 80, height: 12, radius: 4),
                ],
              ),
            ),
          );
        } else if (state is GatergroyFaliure) {
          print("❌ Category load failed: ${state.errMessage}");
          return Center(child: Text('Error: ${state.errMessage}'));
        } else if (state is GatergroySucess) {
          final categories = state.catergoryModel.data?.items ?? [];
          print("✅ Categories loaded: ${categories.length}");

          if (categories.isEmpty) {
            return const Center(child: Text("No categories found"));
          }

          return CommonSection(
            isbestseller_favourotiteite: false,
            title: "Categories",
            onViewAllTap: () {},
            items: categories.map((category) {
              print("📦 Category: ${category.name} - ${category.logoUrl}");
              return GategoryBrandsitem(
                image: category.logoUrl ?? "",
                text: category.name ?? "Unknown",
              );
            }).toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
