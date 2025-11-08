part of 'company_cubit.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanySuccess extends CompanyState {
  final CompanyModel companyModel;
  CompanySuccess({required this.companyModel});
}

class Companyfaliure extends CompanyState {
  final String errMessage;

  Companyfaliure({required this.errMessage});
}

class Companyloading extends CompanyState {}
