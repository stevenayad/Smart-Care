import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smartcare/features/home/data/Model/category_paginted_model/item.dart';
import 'package:smartcare/features/home/data/Model/company_paginted_model/item.dart';

abstract class PaginatedCategoryState extends Equatable {
  const PaginatedCategoryState();

  @override
  List<Object?> get props => [];
}

class PaginatedCompanyInitial extends PaginatedCategoryState {}

class PaginatedCategoryLoading extends PaginatedCategoryState {
  final List<GategoryItem> oldCompanies;
  final bool isFirstFetch;

  const PaginatedCategoryLoading({
    required this.oldCompanies,
    required this.isFirstFetch,
  });

  @override
  List<Object?> get props => [oldCompanies, isFirstFetch];
}

class PaginatedCategorySuccess extends PaginatedCategoryState {
  final List<GategoryItem> category;

  const PaginatedCategorySuccess({required this.category});

  @override
  List<Object?> get props => [category];
}

class PaginatedCompanyError extends PaginatedCategoryState {
  final String errMessage;

  const PaginatedCompanyError({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
