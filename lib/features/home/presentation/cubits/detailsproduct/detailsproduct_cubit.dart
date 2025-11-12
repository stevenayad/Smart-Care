import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';

part 'detailsproduct_state.dart';

class DetailsproductCubit extends Cubit<DetailsproductState> {
  DetailsproductCubit(this.detaisProductRepo) : super(DetailsproductInitial());

  final DetaisProductRepo detaisProductRepo;
  Future<void> getproductdetails(String id) async {
    emit(DetailsproductLoading());
    final result = await detaisProductRepo.getdetailsproduct(id);

    result.fold(
      (failure) {
        emit(DetailsproductFaliure(errMesssage: failure.errMessage));
      },
      (model) {
        emit(DetailsproductSuccess(detialsProductModel: model));
      },
    );
  }
}
