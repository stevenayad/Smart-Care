import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/Bloc/steps_bloc/steps_bloc.dart';
import 'package:smartcare/features/auth/presentation/Bloc/steps_bloc/steps_event.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_form_layout.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_validator.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_1_personal_info.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_2_details.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_3_address.dart';

class RegisterCardContent extends StatefulWidget {
  final bool isLoading;

  const RegisterCardContent({super.key, required this.isLoading});

  @override
  State<RegisterCardContent> createState() => _RegisterCardContentState();
}

class _RegisterCardContentState extends State<RegisterCardContent> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  XFile? _profileImage;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  int? _gender;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressLabelController = TextEditingController();
  final TextEditingController _addressAdditionalInfoController =
      TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  bool _isPrimaryAddress = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _addressLabelController.dispose();
    _addressAdditionalInfoController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  void _onNextPressed(int currentStep) {
    String? errorMessage;
    switch (currentStep) {
      case 0:
        errorMessage = RegisterValidator.validateStep1(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          userName: _usernameController.text,
          phoneNumber: _phoneController.text,
        );
        if (errorMessage == null && _profileImage == null) {
          errorMessage = 'Please select a profile image.';
        }
        break;
      case 1:
        errorMessage = RegisterValidator.validateStep2(
          birthDate: _birthDateController.text,
          gender: _gender,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
        break;
    }

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      context.read<StepsBloc>().add(
        NextStepRequested(
          currentStep: currentStep,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          birthDate: _birthDateController.text,
          gender: _gender,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          profileImage: _profileImage,
          userName: _usernameController.text,
          phoneNumber: _phoneController.text,
        ),
      );
    }
  }

  void _onRegister() {
    final String? errorMessage = RegisterValidator.validateStep3(
      address: _addressController.text,
      addressLabel: _addressLabelController.text,
      addressadditionalLabel: _addressAdditionalInfoController.text,
      latitude: _latitudeController.text,
      longitude: _longitudeController.text,
    );

    if (errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
      return;
    }

    context.read<AuthBloc>().add(
      RegisterButtonPressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        userName: _usernameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
        birthDate: _birthDateController.text,
        gender: _gender!,
        profileImage: _profileImage!,
        accountType: 0,
        address: _addressController.text,
        addressLabel: _addressLabelController.text,
        addressAdditionalInfo: _addressAdditionalInfoController.text,
        addressLatitude: double.tryParse(_latitudeController.text) ?? 30.30,
        addressLongitude: double.tryParse(_longitudeController.text) ?? 30.30,
        addressIsPrimary: _isPrimaryAddress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepsBloc, StepsState>(
      builder: (context, state) {
        return RegisterFormLayout(
          state: state,
          isLoading: widget.isLoading,
          onNext: () => _onNextPressed(state.currentStep),
          onBack: () => context.read<StepsBloc>().add(PreviousStepRequested()),
          onRegister: _onRegister,
          stepContent: buildCurrentStep(state.currentStep),
        );
      },
    );
  }

  Widget buildCurrentStep(int step) {
    switch (step) {
      case 0:
        return Step1PersonalInfo(
          formKey: GlobalKey<FormState>(), // Dummy key
          profileImage: _profileImage,
          onPickImage: _pickImage,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          usernameController: _usernameController,
          phoneController: _phoneController,
          emailController: _emailController,
        );
      case 1:
        return Step2Details(
          formKey: GlobalKey<FormState>(), // Dummy key
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          birthDateController: _birthDateController,
          gender: _gender,
          onGenderChanged: (val) => setState(() => _gender = val),
        );
      case 2:
      default:
        return Step3Address(
          formKey: GlobalKey<FormState>(), // Dummy key
          addressController: _addressController,
          addressLabelController: _addressLabelController,
          latitudeController: _latitudeController,
          longitudeController: _longitudeController,
          isPrimaryAddress: _isPrimaryAddress,
          addressAdditionalInfoController: _addressAdditionalInfoController,
          onPrimaryAddressChanged: (val) =>
              setState(() => _isPrimaryAddress = val!),
        );
    }
  }
}
