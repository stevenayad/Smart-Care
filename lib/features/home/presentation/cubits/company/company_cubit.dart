import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/company_paginted_model/paginted_model.dart';
import 'package:smartcare/features/home/data/Model/productforcompany/item.dart';
import 'package:smartcare/features/home/data/Model/productforcompany/productforcompany.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit(this.homeRepo) : super(CompanyInitial());

  final HomeRepo homeRepo;

  String? _activeCompanyId;
  int currentPage = 1;
  int totalPages = 1;

  Future<void> fetchcomapy() async {
    emit(Companyloading());
    try {
      print("🚀 About to call repo...");

      var result = await homeRepo.getcomapny();

      print("✨ Repository call finished successfully.");

      result.fold(
        (failure) {
          print("❌ Failure: ${failure.errMessage}");
          emit(Companyfaliure(errMessage: failure.errMessage));
        },
        (model) {
          emit(CompanySuccess(companyModel: model));
        },
      );
    } catch (e, s) {
      print("====================================");
      print("❌ 🚨 CRASH FOUND IN CUBIT CATCH BLOCK:");
      print("❌ Category parse error: $e");
      print(s);
      emit(Companyfaliure(errMessage: e.toString()));
    }
  }

  List<ProductItemModel> allCompanies = [];
  int page = 0;
  bool isLoading = false;
  Future<void> getProductForCompany(
    String idCompany, {
    int pageNumber = 1,
  }) async {
    if (isLoading) return;
    isLoading = true;
    _activeCompanyId = idCompany;
    emit(Companyloading());

    final result = await homeRepo.loadproductforcompany(pageNumber, idCompany);

    result.fold(
      (failure) {
        emit(Companyfaliure(errMessage: failure.errMessage));
      },
      (model) {
        page = pageNumber;
        currentPage = pageNumber;
        totalPages = model.data?.totalPages ?? 1;

        emit(ProductCompanySuccess(productforcompany: model));
      },
    );

    isLoading = false;
  }

  Future<void> loadFirstPage(String companyId) async {
    currentPage = 1;
    totalPages = 1;
    await getProductForCompany(companyId, pageNumber: 1);
  }

  Future<void> nextPage() async {
    final id = _activeCompanyId;
    if (id == null) return;
    if (currentPage >= totalPages) return;
    await getProductForCompany(id, pageNumber: currentPage + 1);
  }

  Future<void> previousPage() async {
    final id = _activeCompanyId;
    if (id == null) return;
    if (currentPage <= 1) return;
    await getProductForCompany(id, pageNumber: currentPage - 1);
  }

  void resetProducts() {
    allCompanies.clear();
    page = 0;
    _activeCompanyId = null;
    currentPage = 1;
    totalPages = 1;
    emit(CompanyInitial());
  }
}
