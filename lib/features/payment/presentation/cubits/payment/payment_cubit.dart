import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/payment/data/Model/intentpayment_model/intentpayment_model.dart';
import 'package:smartcare/features/payment/data/Model/payment_cash_model.dart';
import 'package:smartcare/features/payment/data/Model/payment_model/payment_model.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymentRepo paymentRepo;
  Future<void> ConfrimOrderIntent(String orderid, int provider) async {
    emit(PaymentLoading());

    final result = await paymentRepo.PaymentIntentOrder(provider, orderid);
    result.fold(
      (failure) => emit(PaymentFlaiure(errmessage: failure.errMessage)),
      (model) {
        final secret = model.data?.clientPaymentToken;
        if (secret == null || secret.isEmpty) {
          emit(PaymentFlaiure(errmessage: "Invalid payment data"));
        } else {
          emit(PaymentIntentReady(secret));
        }
      },
    );
  }

  Future<void> ConfrimOrderCash(String id) async {
    emit(PaymentLoading());
    final result = await paymentRepo.PaymentCashOrder(id);
    result.fold(
      (failure) => emit(PaymentFlaiure(errmessage: failure.errMessage)),
      (model) => emit(PaymentCashSuccess(paymentModel: model)),
    );
  }

  int getPaymentProvider() {
    final countryCode = PlatformDispatcher.instance.locale.countryCode ?? "US";

    return countryCode == "EG" ? 1 : 0;
  }
}
