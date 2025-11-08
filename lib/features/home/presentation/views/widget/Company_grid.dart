import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/data/Model/paginted_model/item.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/search/search_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/gategory_brandsitem.dart';
import 'package:smartcare/features/home/presentation/views/widget/shimmer_grid.dart';

class PaginatedCompanyGrid extends StatefulWidget {
  const PaginatedCompanyGrid({super.key});

  @override
  State<PaginatedCompanyGrid> createState() => _PaginatedCompanyGridState();
}

class _PaginatedCompanyGridState extends State<PaginatedCompanyGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, searchState) {
        // ✅ لو حالة البحث فيها نتائج
        if (searchState is SearchSucess && searchState.searchModel.isNotEmpty) {
          final searchResults = searchState.searchModel;

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final company = searchResults[index];
              return GategoryBrandsitem(
                image: company.logoUrl ?? "assets/image/bayer.png",
                text: company.name ?? "Unknown",
              );
            },
          );
        }

        // ✅ لو البحث فاضي أو مفيش نتائج أو تم مسح النص → نعرض الشركات العادية
        return BlocBuilder<PaginatedCompanyCubit, PaginatedCompanyState>(
          builder: (context, state) {
            final cubit = context.read<PaginatedCompanyCubit>();

            if (state is PaginatedCompanyLoading &&
                cubit.allCompanies.isEmpty) {
              return buildShimmerGrid();
            }

            if (state is PaginatedCompanyFailure) {
              return Center(
                child: Text(
                  "❌ ${state.errMessage}",
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              );
            }

            if (state is PaginatedCompanySuccess) {
              final companies = state.company;

              return RefreshIndicator(
                onRefresh: () async {
                  await cubit.fetchPaginatedCompany(isRefresh: true);
                  _scrollToTop();
                },
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: companies.length + 1,
                  itemBuilder: (context, index) {
                    if (index < companies.length) {
                      final company = companies[index];
                      return GategoryBrandsitem(
                        image: company.logoUrl ?? "assets/image/bayer.png",
                        text: company.name ?? "Unknown",
                      );
                    }

                    if (cubit.hasMore) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: () async {
                            await cubit.fetchPaginatedCompany();
                            _scrollToTop();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: cubit.isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Row(
                                      children: const [
                                        Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            "Load More",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "No Companys ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
