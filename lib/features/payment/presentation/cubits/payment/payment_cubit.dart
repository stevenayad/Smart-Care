import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/payment/data/Model/payment_model/payment_model.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymentRepo paymentRepo;
  Future<void> ConfrimOrder(String id) async {
    emit(PaymentLoading());
    final result = await paymentRepo.PaymentOrder(id);
    result.fold(
      (failure) => emit(PaymentFlaiure(errmessage: failure.errMessage)),
      (model) => emit(PaymentSuccess(paymentModel: model)),
    );
  }
}
