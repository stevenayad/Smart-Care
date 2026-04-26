import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/auth/presentation/Manager/request_bloc/request_bloc.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_validator.dart';

part 'logic_register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthBloc authBloc;
  late final StreamSubscription authBlocSubscription;

  RegisterCubit({required this.authBloc}) : super(RegisterState()) {
    authBlocSubscription = authBloc.stream.listen((authState) {
      if (isClosed) return;
      if (authState is AuthLoading) {
        emit(state.copyWith(isLoading: true));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressLabelController = TextEditingController();
  final TextEditingController addressAdditionalInfoController =
      TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    addressLabelController.dispose();
    addressAdditionalInfoController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    return super.close();
  }

  void updateGender(int? gender) {
    emit(state.copyWith(gender: gender));
  }

  void updatePrimaryAddress(bool isPrimary) {
    emit(state.copyWith(isPrimaryAddress: isPrimary));
  }

  void clearErrorMessage() {
    emit(state.copyWith(clearErrorMessage: true));
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      emit(state.copyWith(profileImage: pickedFile, clearErrorMessage: true));
    }
  }

  void onNextPressed() {
    String? errorMessage;
    switch (state.currentStep) {
      case 0:
        errorMessage = RegisterValidator.validateStep1(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          userName: usernameController.text,
          phoneNumber: phoneController.text,
        );
        if (errorMessage == null && state.profileImage == null) {
          errorMessage = 'Please select a profile image.';
        }
        break;
      case 1:
        errorMessage = RegisterValidator.validateStep2(
          birthDate: birthDateController.text,
          gender: state.gender,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
        break;
    }

    if (errorMessage != null) {
      emit(state.copyWith(errorMessage: errorMessage));
    } else {
      if (state.currentStep < 2) {
        emit(
          state.copyWith(
            currentStep: state.currentStep + 1,
            clearErrorMessage: true,
          ),
        );
      }
    }
  }

  void onBackPressed() {
    if (state.currentStep > 0) {
      emit(
        state.copyWith(
          currentStep: state.currentStep - 1,
          clearErrorMessage: true,
        ),
      );
    }
  }

  void onRegister() {
    final String? errorMessage = RegisterValidator.validateStep3(
      address: addressController.text,
      addressLabel: addressLabelController.text,
      addressadditionalLabel: addressAdditionalInfoController.text,
      latitude: latitudeController.text,
      longitude: longitudeController.text,
    );

    if (errorMessage != null) {
      emit(state.copyWith(errorMessage: errorMessage));
      return;
    }

    emit(state.copyWith(clearErrorMessage: true));

    authBloc.add(
      RegisterButtonPressed(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: usernameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        birthDate: birthDateController.text,
        gender: state.gender!,
        profileImage: state.profileImage!,
        accountType: 0,
        address: addressController.text,
        addressLabel: addressLabelController.text,
        addressAdditionalInfo: addressAdditionalInfoController.text,
        addressLatitude: double.tryParse(latitudeController.text) ?? 30.30,
        addressLongitude: double.tryParse(longitudeController.text) ?? 30.30,
        addressIsPrimary: state.isPrimaryAddress,
      ),
    );
  }
}
