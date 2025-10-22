part of 'steps_bloc.dart';
class StepsState extends Equatable {
  final int currentStep;

  const StepsState({
    this.currentStep = 0,
  });

  StepsState copyWith({
    int? currentStep,
  }) {
    return StepsState(
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object> get props => [currentStep];
}