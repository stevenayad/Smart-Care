import 'package:equatable/equatable.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';
import 'package:smartcare/features/products/data/models/company_model.dart';

class CategorySheetSnap extends Equatable {
  final List<CategoryModel> categories;
  final String selectedName;

  const CategorySheetSnap({
    required this.categories,
    required this.selectedName,
  });

  @override
  List<Object?> get props => [categories, selectedName];
}

class CompanySheetSnap extends Equatable {
  final List<CompanyModel> companies;
  final String selectedName;

  const CompanySheetSnap({required this.companies, required this.selectedName});

  @override
  List<Object?> get props => [companies, selectedName];
}

class ProductUiState extends Equatable {
  final String categoryButtonLabel;
  final String companyButtonLabel;

  final int categorySheetNonce;
  final CategorySheetSnap? categorySheetSnap;

  final int companySheetNonce;
  final CompanySheetSnap? companySheetSnap;

  final int filterSheetNonce;

  const ProductUiState({
    required this.categoryButtonLabel,
    required this.companyButtonLabel,
    required this.categorySheetNonce,
    this.categorySheetSnap,
    required this.companySheetNonce,
    this.companySheetSnap,
    required this.filterSheetNonce,
  });

  factory ProductUiState.initial() {
    return const ProductUiState(
      categoryButtonLabel: 'Loading...',
      companyButtonLabel: 'Loading...',
      categorySheetNonce: 0,
      companySheetNonce: 0,
      filterSheetNonce: 0,
    );
  }

  ProductUiState copyWith({
    String? categoryButtonLabel,
    String? companyButtonLabel,
    int? categorySheetNonce,
    CategorySheetSnap? categorySheetSnap,
    bool clearCategorySheetSnap = false,
    int? companySheetNonce,
    CompanySheetSnap? companySheetSnap,
    bool clearCompanySheetSnap = false,
    int? filterSheetNonce,
  }) {
    return ProductUiState(
      categoryButtonLabel: categoryButtonLabel ?? this.categoryButtonLabel,
      companyButtonLabel: companyButtonLabel ?? this.companyButtonLabel,
      categorySheetNonce: categorySheetNonce ?? this.categorySheetNonce,
      categorySheetSnap: clearCategorySheetSnap
          ? null
          : (categorySheetSnap ?? this.categorySheetSnap),
      companySheetNonce: companySheetNonce ?? this.companySheetNonce,
      companySheetSnap: clearCompanySheetSnap
          ? null
          : (companySheetSnap ?? this.companySheetSnap),
      filterSheetNonce: filterSheetNonce ?? this.filterSheetNonce,
    );
  }

  @override
  List<Object?> get props => [
    categoryButtonLabel,
    companyButtonLabel,
    categorySheetNonce,
    categorySheetSnap,
    companySheetNonce,
    companySheetSnap,
    filterSheetNonce,
  ];
}
