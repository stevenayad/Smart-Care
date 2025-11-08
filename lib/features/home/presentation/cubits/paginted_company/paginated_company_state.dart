part of 'paginated_company_cubit.dart';

abstract class PaginatedCompanyState extends Equatable {
  const PaginatedCompanyState();

  @override
  List<Object?> get props => [];
}

class PaginatedCompanyInitial extends PaginatedCompanyState {}

class PaginatedCompanyLoading extends PaginatedCompanyState {}

class PaginatedCompanySuccess extends PaginatedCompanyState {
  final List<Item> company;

  const PaginatedCompanySuccess({required this.company});

  @override
  List<Object?> get props => [company];
}

class PaginatedCompanyFailure extends PaginatedCompanyState {
  final String errMessage;

  const PaginatedCompanyFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
