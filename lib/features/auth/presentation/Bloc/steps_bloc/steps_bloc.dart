import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/auth/presentation/Bloc/steps_bloc/steps_event.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_validator.dart';



part 'steps_state.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  StepsBloc() : super(const StepsState()) {
    on<NextStepRequested>(_onNextStepRequested);
    on<PreviousStepRequested>(_onPreviousStepRequested);
  }

  void _onNextStepRequested(NextStepRequested event, Emitter<StepsState> emit) {
    String? errorMessage;

    switch (event.currentStep) {
      case 0:
        errorMessage = RegisterValidator.validateStep1(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
        );
        if (errorMessage == null && event.profileImage == null) {
          errorMessage = 'Please select a profile image.';
        }
        break;
      case 1:
        errorMessage = RegisterValidator.validateStep2(
          birthDate: event.birthDate,
          gender: event.gender,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        break;
    }

    if (errorMessage == null) {
      if (state.currentStep < 2) { 
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    } else {
      
    }
  }

  void _onPreviousStepRequested(PreviousStepRequested event, Emitter<StepsState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }
}