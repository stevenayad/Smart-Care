part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

class PaymentStripeSuccess extends PaymentState {}

class PaymentPaymobSuccess extends PaymentState {}

class PaymentCashSuccess extends PaymentState {
  final PaymentCashModel paymentModel;

  const PaymentCashSuccess({required this.paymentModel});
}

class PaymentFlaiure extends PaymentState {
  final String errmessage;

  const PaymentFlaiure({required this.errmessage});
}

class PaymentLoading extends PaymentState {}

class PaymentMethodChanged extends PaymentState {
  final int index;

  const PaymentMethodChanged(this.index);
}

class LoadProviderDone extends PaymentState {
  final int provider;

  LoadProviderDone({required this.provider});
}
