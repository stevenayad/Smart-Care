import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/shimer_box.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/home/presentation/views/company_with_product_screen.dart';

class Company extends StatelessWidget {
  const Company({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.18;
    final itemHeight = itemWidth;

    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        if (state is Companyloading) {
          return SizedBox(
            height: itemHeight + 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) => Column(
                children: [
                  shimmerBox(height: itemHeight, width: itemWidth, radius: 16),
                  const SizedBox(height: 8),
                  shimmerBox(height: 12, width: itemWidth * 0.8, radius: 6),
                ],
              ),
            ),
          );
        }

        if (state is Companyfaliure) {
          return Center(child: Text("Error: ${state.errMessage}"));
        }

        if (state is CompanySuccess) {
          final companies = state.companyModel.data?.items ?? [];

          if (companies.isEmpty) {
            return const Center(child: Text("No companies found"));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      'Company',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF083F2D),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyWithProductsScreen(),
                        ),
                      );
                    },
                    child: Text('See All'),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),

                child: Container(
                  height: 3,
                  width: 85,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(
                height: itemHeight + 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: companies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final company = companies[index];

                    return Column(
                      children: [
                        Container(
                          height: itemHeight,
                          width: itemWidth,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F6EE),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.12),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:
                                (company.logoUrl != null &&
                                    company.logoUrl!.isNotEmpty)
                                ? Image.network(
                                    company.logoUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  )
                                : const Icon(
                                    Icons.local_pharmacy,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          width: itemWidth,
                          child: Text(
                            company.name ?? "Unknown",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.032,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
