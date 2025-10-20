// FILE: features/auth/presentation/register/views/widgets/register_card_content.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/address_form.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/personal_info_form.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/profile_imagepicker.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';


class RegisterCardContent extends StatefulWidget {
  final bool isLoading;
  const RegisterCardContent({super.key, required this.isLoading});

  @override
  State<RegisterCardContent> createState() => _RegisterCardContentState();
}

class _RegisterCardContentState extends State<RegisterCardContent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressLabelController = TextEditingController();
  final TextEditingController _addressAdditionalInfoController =
      TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  XFile? _profileImage;
  int? _gender;
  bool _isPrimaryAddress = true;
  final int _accountType = 0;

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
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill the missing.'),
            backgroundColor: Colors.orangeAccent),
      );
      return;
    }
    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a profile image.'),
            backgroundColor: Colors.orangeAccent),
      );
      return;
    }
    if (_gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a gender.'),
            backgroundColor: Colors.orangeAccent),
      );
      return;
    }

    context.read<AuthBloc>().add(RegisterButtonPressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        userName: _usernameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
        birthDate: _birthDateController.text,
        gender: _gender!,
        profileImage: _profileImage!,
        accountType: _accountType,
        address: _addressController.text,
        addressLabel: _addressLabelController.text,
        addressAdditionalInfo: _addressAdditionalInfoController.text,
        addressLatitude: double.tryParse(_latitudeController.text) ?? 0.0,
        addressLongitude: double.tryParse(_longitudeController.text) ?? 0.0,
        addressIsPrimary: _isPrimaryAddress));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Register', style: Theme.of(context).textTheme.titleLarge),
            Container(
              height: 2,
              width: 120,
              color: AppThemes.lightTheme.colorScheme.surface,
              margin: const EdgeInsets.only(top: 4, bottom: 20),
            ),

            ProfileImagePicker(
              image: _profileImage,
              onPickImage: _pickImage,
            ),
            const SizedBox(height: 20),

            PersonalInfoForm(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              usernameController: _usernameController,
              phoneController: _phoneController,
              emailController: _emailController,
              birthDateController: _birthDateController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              gender: _gender,
              onGenderChanged: (val) => setState(() => _gender = val),
            ),
            
            AddressForm(
              addressController: _addressController,
              addressLabelController: _addressLabelController,
              addressAdditionalInfoController: _addressAdditionalInfoController,
              latitudeController: _latitudeController,
              longitudeController: _longitudeController,
              isPrimaryAddress: _isPrimaryAddress,
              onPrimaryAddressChanged: (val) =>
                  setState(() => _isPrimaryAddress = val!),
            ),
            const SizedBox(height: 30),

            // The main action button remains in the parent widget.
            Center(
              child: widget.isLoading
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      text: 'Register',
                      onPressed: _onRegister,
                      elevation: 8,
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}