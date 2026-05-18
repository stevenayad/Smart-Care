import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/Manager/logic_register_cubit/logic_register_cubit.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_1_personal_info.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_2_details.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_3_address.dart';

Widget buildCurrentStep(int step, RegisterCubit cubit, RegisterState state) {
  switch (step) {
    case 0:
      return Step1PersonalInfo(
        formKey: cubit.formKeyStep1,
        profileImage: state.profileImage,
        onPickImage: cubit.pickImage,
        firstNameController: cubit.firstNameController,
        lastNameController: cubit.lastNameController,
        usernameController: cubit.usernameController,
        phoneController: cubit.phoneController,
        emailController: cubit.emailController,
      );
    case 1:
      return Step2Details(
        formKey: cubit.formKeyStep2,
        passwordController: cubit.passwordController,
        confirmPasswordController: cubit.confirmPasswordController,
        birthDateController: cubit.birthDateController,
        gender: state.gender,
        onGenderChanged: (val) => cubit.updateGender(val),
      );
    case 2:
    default:
      return Step3Address(
        formKey: cubit.formKeyStep3,
        addressController: cubit.addressController,
        addressLabelController: cubit.addressLabelController,
        latitudeController: cubit.latitudeController,
        longitudeController: cubit.longitudeController,
        isPrimaryAddress: state.isPrimaryAddress,
        addressAdditionalInfoController: cubit.addressAdditionalInfoController,
        onPrimaryAddressChanged: (val) =>
            cubit.updatePrimaryAddress(val ?? true),
        locationMethod: state.locationMethod,
        onLocationMethodChanged: (val) => cubit.updateLocationMethod(val),
      );
  }
}
