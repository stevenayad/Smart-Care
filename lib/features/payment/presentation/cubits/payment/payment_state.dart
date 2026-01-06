part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final IntentpaymentModel paymentModel;

  PaymentSuccess({required this.paymentModel});
}

class PaymentIntentReady extends PaymentState {
  final String clientSecret;
  PaymentIntentReady(this.clientSecret);
}

class PaymentCashSuccess extends PaymentState {
  final PaymentCashModel paymentModel;

  PaymentCashSuccess({required this.paymentModel});
}

class PaymentFlaiure extends PaymentState {
  final String errmessage;

  PaymentFlaiure({required this.errmessage});
}

class PaymentLoading extends PaymentState {}
