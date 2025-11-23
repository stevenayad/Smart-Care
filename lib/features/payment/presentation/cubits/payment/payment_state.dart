part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentModel paymentModel;

  PaymentSuccess({required this.paymentModel});
}

class PaymentFlaiure extends PaymentState {
  final String errmessage;

  PaymentFlaiure({required this.errmessage});
}

class PaymentLoading extends PaymentState {}
