part of 'signalrdetials_cubit.dart';

sealed class SignalrdetialsState extends Equatable {
  const SignalrdetialsState();

  @override
  List<Object> get props => [];
}

final class SignalrdetialsInitial extends SignalrdetialsState {}

class SignalrdetialsUpdated extends SignalrdetialsState {
  final ProductAvailability model;

  SignalrdetialsUpdated(this.model);
}
