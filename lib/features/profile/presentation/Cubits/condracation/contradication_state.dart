part of 'contradication_cubit.dart';

sealed class ContradicationState extends Equatable {
  const ContradicationState();

  @override
  List<Object> get props => [];
}

final class ContradicationInitial extends ContradicationState {}

final class ContradicationLoading extends ContradicationState {}

final class ContradicationSuccess extends ContradicationState {
  final MedicalWarningResponse medicalWarningResponse;

  ContradicationSuccess({required this.medicalWarningResponse});
}

final class ContradicationError extends ContradicationState {
  final String message;

  ContradicationError({required this.message});
}
