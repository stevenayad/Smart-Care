import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smartcare/features/payment/data/Model/payment_cash_model.dart';
import 'package:smartcare/features/payment/data/repo/location_services.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
import 'package:smartcare/features/payment/data/repo/payment_servcies.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymentRepo paymentRepo;

  int selectedIndex = 0;
 int paymentProvider = 0;
  void selectPaymentMethod(int index) {
    selectedIndex = index;
    emit(PaymentMethodChanged(index));
  }

  Future<void> processIntentPayment(String orderid) async {
    
    emit(PaymentLoading());

    final result = await paymentRepo.PaymentIntentOrder(paymentProvider, orderid);
    await result.fold(
      (failure) async => emit(PaymentFlaiure(errmessage: failure.errMessage)),
      (model) async {
        final secret = model.data?.clientPaymentToken;
        if (secret == null || secret.isEmpty) {
          emit(PaymentFlaiure(errmessage: "Invalid payment data"));
          return;
        }

        try {
          if (paymentProvider == 0) {
            await StripeServices.payWithStripe(secret);
            emit(PaymentStripeSuccess());
          } else if (paymentProvider == 1) {
            await PaymobRedirectService.startPayment(clientSecret: secret);
            emit(PaymentPaymobSuccess());
          }
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
  

  print('🚀 Detecting country in Cubit ...');

  emit(PaymentLoading());

  final countryCode = await detectCountryByIP();

  paymentProvider = countryCode == "EG" ? 1 : 0;

  emit(LoadProviderDone(provider: paymentProvider));
}
}
