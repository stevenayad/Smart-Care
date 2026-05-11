import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smartcare/features/payment/data/Model/payment_cash_model.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_services.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
import 'package:smartcare/features/payment/data/services/location_services.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo, {required this.paymentService})
    : super(PaymentInitial());

  final PaymentRepo paymentRepo;
  final PaymentService paymentService;

  int selectedIndex = 0;
  //int? paymentProvider;

  void selectPaymentMethod(int index) {
    selectedIndex = index;
    emit(PaymentMethodChanged(index));
  }

  
  Future<void> processIntentPayment(BuildContext context,String orderid) async {
    emit(PaymentLoading());

    final result = await paymentRepo.PaymentIntentOrder(
      0,
      orderid,
    );

    await result.fold(
      (failure) async => emit(PaymentFlaiure(errmessage: failure.errMessage)),
      (model) async {
        final secret = model.data?.clientPaymentToken;

        if (secret == null || secret.isEmpty) {
          emit(PaymentFlaiure(errmessage: "Invalid payment data"));
          return;
        }


        try {
          await paymentService.pay(context ,secret,0);
          emit(PaymentSuccess());
        } on StripeException catch (e) {
          print('Stripe cancelled: ${e.error.localizedMessage}');
          emit(PaymentFlaiure(errmessage: "Payment was cancelled"));
        } catch (e) {
          print('Unexpected error: $e');
          emit(PaymentFlaiure(errmessage: "Payment failed, please try again"));
        }
      },
    );
  }

  Future<void> processCashPayment(String id) async {
    emit(PaymentLoading());

    final result = await paymentRepo.PaymentCashOrder(id);

    result.fold(
      (failure) => emit(PaymentFlaiure(errmessage: failure.errMessage)),
      (model) => emit(PaymentCashSuccess(paymentModel: model)),
    );
  }

  /*Future<void> loadPaymentProvider() async {
    emit(PaymentLoading());

    final countryCode = await detectCountry();

    paymentProvider = countryCode == "EG" ? 1 : 0;

    emit(LoadProviderDone(provider: paymentProvider!));
  }*/

   Future<void> processPayment(BuildContext  context,  String orderId) async {
    if (selectedIndex == 1) {
      await processCashPayment(orderId);
      return;
    }
    await processIntentPayment(context,orderId);
  }
}
