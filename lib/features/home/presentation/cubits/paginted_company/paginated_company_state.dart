import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/paginted_model/item.dart';

abstract class PaginatedCompanyState extends Equatable {
  const PaginatedCompanyState();

  @override
  List<Object?> get props => [];
}

class PaginatedCompanyInitial extends PaginatedCompanyState {}

class PaginatedCompanyLoading extends PaginatedCompanyState {
  final List<Item> oldCompanies;
  final bool isFirstFetch;

  const PaginatedCompanyLoading({
    required this.oldCompanies,
    required this.isFirstFetch,
  });

  @override
  List<Object?> get props => [oldCompanies, isFirstFetch];
}

class PaginatedCompanySuccess extends PaginatedCompanyState {
  final List<Item> company;

  const PaginatedCompanySuccess({required this.company});

  @override
  List<Object?> get props => [company];
}

class PaginatedCompanyError extends PaginatedCompanyState {
  final String errMessage;

  const PaginatedCompanyError({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
