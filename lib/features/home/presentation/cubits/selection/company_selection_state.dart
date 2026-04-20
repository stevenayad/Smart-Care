import 'package:equatable/equatable.dart';

class CompanySelectionState extends Equatable {
  final String? selectedCompanyId;

  const CompanySelectionState({this.selectedCompanyId});

  @override
  List<Object?> get props => [selectedCompanyId];
}
