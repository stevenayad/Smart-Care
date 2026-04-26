part of 'logic_register_cubit.dart';

class RegisterState {
  final int currentStep;
  final XFile? profileImage;
  final int? gender;
  final bool isPrimaryAddress;
  final bool isLoading;
  final String? errorMessage;

  RegisterState({
    this.currentStep = 0,
    this.profileImage,
    this.gender,
    this.isPrimaryAddress = true,
    this.isLoading = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    int? currentStep,
    XFile? profileImage,
    int? gender,
    bool? isPrimaryAddress,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return RegisterState(
      currentStep: currentStep ?? this.currentStep,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      isPrimaryAddress: isPrimaryAddress ?? this.isPrimaryAddress,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }
}
