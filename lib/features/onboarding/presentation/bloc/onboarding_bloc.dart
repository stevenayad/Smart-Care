import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<CheckOnboardingEvent>(onCheckOnboarding);
    on<CompleteOnboardingEvent>(onCompleteOnboarding);
  }

  void onCheckOnboarding(
    CheckOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) {
    emit(OnboardingInitial());
    final isCompleted = CacheHelper.isOnboardingCompleted();
    if (isCompleted) {
      emit(OnboardingFinished());
    } else {
      emit(OnboardingShow());
    }
  }

  void onCompleteOnboarding(
    CompleteOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingInitial());
    await CacheHelper.saveOnboardingCompleted();
    emit(OnboardingFinished());
  }
}
