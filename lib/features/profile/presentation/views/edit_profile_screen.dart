import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_action_buttons.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_image_picker.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/profile_form_fields.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doe');
  final _emailController = TextEditingController(text: 'john.doe@gmail.com');
  final _phoneController = TextEditingController(text: '01281959740');
  final _dobController = TextEditingController(text: '01/01/1990');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before saving.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _onCancel() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const EditProfileImagePicker(),
              const SizedBox(height: 30),
              ProfileFormFields(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                dobController: _dobController,
              ),
              const SizedBox(height: 30),
              EditProfileActionButtons(onSave: _onSave, onCancel: _onCancel),
            ],
          ),
        ),
      ),
    );
  }
}
