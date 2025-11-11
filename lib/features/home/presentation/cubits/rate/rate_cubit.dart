import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/rate_input_request_update.dart';
import 'package:smartcare/features/home/data/Model/rate_model.dart';
import 'package:smartcare/features/home/data/Model/rateinputrequest.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  final DetaisProductRepo detaisProductRepo;

  RateCubit(this.detaisProductRepo) : super(RateInitial());

  Future<void> createrate(RateInputRequest rateinputrequest) async {
    emit(Rateloading());

    final result = await detaisProductRepo.makerate(rateinputrequest);

    await result.fold(
      (failure) async {
        if (failure.errMessage.contains('Rate already Exits')) {
          final existingIdrate = await detaisProductRepo.getExistingYourRate(
            rateinputrequest.productId,
          );
          final updateRequest = RateInputRequestUpdate(
            id: existingIdrate,
            productId: rateinputrequest.productId,
            value: rateinputrequest.value,
            createdAt: rateinputrequest.createdAt,
          );
          final updateResult = await detaisProductRepo.updaterate(
            updateRequest,
          );

          updateResult.fold(
            (updateFailure) {
              emit(RateFaliure(errmessage: updateFailure.errMessage));
            },
            (updateModel) {
              emit(RateSuccess(rateModel: updateModel));
            },
          );
        } else {
          emit(RateFaliure(errmessage: failure.errMessage));
        }
      },
      (model) {
        emit(RateSuccess(rateModel: model));
      },
    );
  }

  Future<void> updaterate(RateInputRequestUpdate rateinputrequest) async {
    emit(Rateloading());
    final result = await detaisProductRepo.updaterate(rateinputrequest);
    result.fold(
      (failure) {
        emit(RateFaliure(errmessage: failure.errMessage));
      },
      (model) {
        emit(RateSuccess(rateModel: model));
      },
    );
  }

  Future<void> loadUserRate(String productId) async {
    emit(Rateloading());
    final result = await detaisProductRepo.getUserRates();
    result.fold(
      (failure) => emit(RateFaliure(errmessage: failure.errMessage)),
      (rateModel) {
        final dataList = rateModel.data as List<dynamic>? ?? [];
        final existing = dataList.firstWhere(
          (r) => r['product'] != null && r['product']['productId'] == productId,
          orElse: () => null,
        );

        if (existing != null) {
          emit(
            RateLoaded(rating: ((existing['value'] ?? 0) as num).toDouble()),
          );
        } else {
          emit(RateLoaded(rating: 0));
        }
      },
    );
  }
}
