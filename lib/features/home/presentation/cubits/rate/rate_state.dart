part of 'rate_cubit.dart';

sealed class RateState extends Equatable {
  const RateState();

  @override
  List<Object> get props => [];
}

final class RateInitial extends RateState {}

class RateSuccess extends RateState {
  final RateModel rateModel;

  RateSuccess({required this.rateModel});
}

class RateFaliure extends RateState {
  final String errmessage;

  RateFaliure({required this.errmessage});
}

class Rateloading extends RateState {}

class RateLoaded extends RateState {
  final double rating;

  RateLoaded({required this.rating});
}
