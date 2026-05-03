import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smartcare/features/payment/data/Model/payment_cash_model.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_strategy.dart';
import 'package:smartcare/features/payment/data/repo/location_services.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymentRepo paymentRepo;

  int selectedIndex = 0;
  int paymentProvider = 0;

  PaymentStrategy? _strategy;

  void selectPaymentMethod(int index) {
    selectedIndex = index;
    emit(PaymentMethodChanged(index));
  }

  void setPaymentStrategy(PaymentStrategy strategy) {
    _strategy = strategy;
  }

  Future<void> processIntentPayment(String orderid) async {
    emit(PaymentLoading());

    final result = await paymentRepo.PaymentIntentOrder(
      paymentProvider,
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

        if (_strategy == null) {
          emit(PaymentFlaiure(errmessage: "Payment method not selected"));
          return;
        }

        try {
          await _strategy!.pay(secret);
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

  Future<void> loadPaymentProvider() async {
    emit(PaymentLoading());

    final countryCode = await detectCountry();

    paymentProvider = countryCode == "EG" ? 1 : 0;

    emit(LoadProviderDone(provider: paymentProvider));
  }
}
