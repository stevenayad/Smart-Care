
import 'package:bloc/bloc.dart';
import 'package:smartcare/features/products/data/repositories/products_repository_impl.dart';
import 'companies_event.dart';
import 'companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final ProductsRepositoryImpl repository;
  CompaniesBloc(this.repository) : super(CompaniesInitial()) {
    on<LoadCompanies>(_onLoad);
  }

  Future<void> _onLoad(LoadCompanies event, Emitter<CompaniesState> emit) async {
    emit(CompaniesLoading());
    final res = await repository.getCompanies();
    res.fold(
      (failure) => emit(CompaniesError(failure.errMessage)),
      (companies) => emit(CompaniesLoaded(companies)),
    );
  }
}
