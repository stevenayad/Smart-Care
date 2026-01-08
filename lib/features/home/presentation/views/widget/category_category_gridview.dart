import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_state.dart';

class CategoryProductGridview extends StatefulWidget {
  final String categoryId;

  const CategoryProductGridview({super.key, required this.categoryId});

  @override
  State<CategoryProductGridview> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<CategoryProductGridview> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<CatergoryCubit>().getProductForCatagory(widget.categoryId);
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      currentPage = 1;
      context.read<CatergoryCubit>().getProductForCatagory(
        widget.categoryId,
        pageNumber: currentPage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatergoryCubit, GatergoryState>(
      builder: (context, state) {
        if (state is Companyloading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GategoryCompanySuccess) {
          final products = state.productforcategory.data?.items ?? [];
          final totalPages = state.productforcategory.data?.totalPages ?? 1;
          final cubit = context.read<CatergoryCubit>();

          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                product.mainImageUrl ??
                                    "https://via.placeholder.com/100",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product.nameEn ?? "Unnamed",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${product.price ?? 0} EGP",
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left, size: 30),
                      onPressed: currentPage > 1
                          ? () {
                              setState(() {
                                currentPage--;
                              });
                              cubit.getProductForCatagory(
                                widget.categoryId,
                                pageNumber: currentPage,
                              );
                            }
                          : null,
                    ),
                    Text(
                      "Page $currentPage / $totalPages",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right, size: 30),
                      onPressed: currentPage < totalPages
                          ? () {
                              setState(() {
                                currentPage++;
                              });
                              cubit.getProductForCatagory(
                                widget.categoryId,
                                pageNumber: currentPage,
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text(
              "Select a company to view products",
              style: TextStyle(fontSize: 16),
            ),
          );
        }
      },
    );
  }
}
