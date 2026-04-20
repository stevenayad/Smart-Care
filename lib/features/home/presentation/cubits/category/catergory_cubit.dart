import 'package:bloc/bloc.dart';
import 'package:smartcare/features/home/data/Model/category_paginted_model/category_paginted_model.dart';
import 'package:smartcare/features/home/data/Model/productfor_gategory/productfor_gategory.dart';
import 'package:smartcare/features/home/data/Model/productforcompany/item.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';

part 'catergory_state.dart';

class CatergoryCubit extends Cubit<GatergoryState> {
  CatergoryCubit(this.homerepo) : super(GatergoryInitial());
  final HomeRepo homerepo;

  String? _activeCategoryId;
  int currentPage = 1;
  int totalPages = 1;

  Future<void> fetchGategory() async {
    emit(GatergroyLoading());
    try {
      print("🚀 About to call repo...");

      var result = await homerepo.getGategory();

      print("✨ Repository call finished successfully.");

      result.fold(
        (failure) {
          print("❌ Failure: ${failure.errMessage}");
          emit(GatergroyFaliure(errMessage: failure.errMessage));
        },
        (model) {
          emit(GatergroySucess(catergoryModel: model));
        },
      );
    } catch (e, s) {
      print("====================================");
      print("❌ 🚨 CRASH FOUND IN CUBIT CATCH BLOCK:");
      print("❌ Category parse error: $e");
      print(s);
      emit(GatergroyFaliure(errMessage: e.toString()));
    }
  }

  List<ProductItemModel> allCompanies = [];
  int page = 0;
  bool isLoading = false;
  Future<void> getProductForCatagory(
    String idCompany, {
    int pageNumber = 1,
  }) async {
    if (isLoading) return;
    isLoading = true;
    _activeCategoryId = idCompany;
    emit(GatergroyLoading());

    final result = await homerepo.loadproductforcategory(pageNumber, idCompany);

    result.fold(
      (failure) {
        emit(GatergroyFaliure(errMessage: failure.errMessage));
      },
      (model) {
        page = pageNumber;
        currentPage = pageNumber;
        totalPages = model.data?.totalPages ?? 1;

        emit(GategoryCompanySuccess(productforcategory: model));
      },
    );

    isLoading = false;
  }

  Future<void> loadFirstPage(String categoryId) async {
    currentPage = 1;
    totalPages = 1;
    await getProductForCatagory(categoryId, pageNumber: 1);
  }

  Future<void> nextPage() async {
    final id = _activeCategoryId;
    if (id == null) return;
    if (currentPage >= totalPages) return;
    await getProductForCatagory(id, pageNumber: currentPage + 1);
  }

  Future<void> previousPage() async {
    final id = _activeCategoryId;
    if (id == null) return;
    if (currentPage <= 1) return;
    await getProductForCatagory(id, pageNumber: currentPage - 1);
  }

  void resetProducts() {
    allCompanies.clear();
    page = 0;
    _activeCategoryId = null;
    currentPage = 1;
    totalPages = 1;
    emit(GatergoryInitial());
  }
}
