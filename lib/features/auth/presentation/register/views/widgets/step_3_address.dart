import 'package:flutter/material.dart';
import 'package:smartcare/core/api/services/location_service.dart';
import 'package:smartcare/features/auth/presentation/register/views/map_picker_screen.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/custom_checkbox_field.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/location_picker_radio.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class Step3Address extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController addressController;
  final TextEditingController addressLabelController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController addressAdditionalInfoController;

  final bool isPrimaryAddress;
  final ValueChanged<bool?> onPrimaryAddressChanged;

  const Step3Address({
    super.key,
    required this.formKey,
    required this.addressController,
    required this.addressLabelController,
    required this.latitudeController,
    required this.longitudeController,
    required this.isPrimaryAddress,
    required this.onPrimaryAddressChanged,
    required this.addressAdditionalInfoController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: addressController,
            icon: Icons.location_on_outlined,
            label: 'Address',
            hint: 'e.g., 123 Main St',
            validator: (v) => v!.isEmpty ? 'Address is required' : null,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: addressLabelController,
            icon: Icons.label_outline,
            label: 'Address Label',
            hint: 'e.g., Home, Work',
            validator: (v) => v!.isEmpty ? 'Address is required' : null,
          ),
          const SizedBox(height: 20),
          CustomCheckboxField(
            label: 'Set as primary address',
            value: isPrimaryAddress,
            onChanged: onPrimaryAddressChanged,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: addressAdditionalInfoController,
            icon: Icons.label_outline,
            label: 'address Additional Info Controller Label',
            hint: 'e.g., near to ainshams unversity',
            validator: (v) =>
                v!.isEmpty ? 'address Additional is required' : null,
          ),
          const SizedBox(height: 20),
          LocationPickerRadio(
            latitudeController: latitudeController,
            longitudeController: longitudeController,
          ),
        ],
      ),
    );
  }
}
