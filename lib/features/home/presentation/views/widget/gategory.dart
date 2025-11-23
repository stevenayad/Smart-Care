import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.20;
    final itemHeight = itemWidth;

    return BlocBuilder<CatergoryCubit, GatergoryState>(
      builder: (context, state) {
        if (state is GatergroyLoading) {
          return SizedBox(
            height: itemHeight + 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: itemWidth * 0.8,
                    height: 12,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          );
        }

        if (state is GatergroyFaliure) {
          return Center(child: Text('Error: ${state.errMessage}'));
        }

        if (state is GatergroySucess) {
          final categories = state.catergoryModel.data?.items ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF083F2D),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),

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
                height: itemHeight + 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 18),
                  itemBuilder: (context, index) {
                    final category = categories[index];

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
                                color: Colors.green.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:
                                category.logoUrl != null &&
                                    category.logoUrl!.isNotEmpty
                                ? Image.network(
                                    category.logoUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.local_pharmacy,
                                      size: 35,
                                      color: Colors.green,
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
                            category.name ?? "Unknown",
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
