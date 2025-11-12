import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';

class ProductGridView extends StatefulWidget {
  final String companyId;

  const ProductGridView({super.key, required this.companyId});

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<CompanyCubit>().getProductForCompany(widget.companyId);
  }

  @override
  void didUpdateWidget(covariant ProductGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.companyId != widget.companyId) {
      currentPage = 1;
      context.read<CompanyCubit>().getProductForCompany(
        widget.companyId,
        pageNumber: currentPage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        if (state is Companyloading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductCompanySuccess) {
          final products = state.productforcompany.data?.items ?? [];
          final totalPages = state.productforcompany.data?.totalPages ?? 1;
          final cubit = context.read<CompanyCubit>();

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
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            product.mainImageUrl ??
                                "https://via.placeholder.com/100",
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product.nameEn ?? "Unnamed",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${product.price ?? 0} EGP",
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
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
                              cubit.getProductForCompany(
                                widget.companyId,
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
                              cubit.getProductForCompany(
                                widget.companyId,
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
          return const Center(child: Text("Select a company to view products"));
        }
      },
    );
  }
}
