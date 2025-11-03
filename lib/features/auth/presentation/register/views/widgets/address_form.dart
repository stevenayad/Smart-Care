import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/custom_checkbox_field.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/form_section_header.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController addressLabelController;
  final TextEditingController addressAdditionalInfoController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final bool isPrimaryAddress;
  final ValueChanged<bool?> onPrimaryAddressChanged;

  const AddressForm({
    super.key,
    required this.addressController,
    required this.addressLabelController,
    required this.addressAdditionalInfoController,
    required this.latitudeController,
    required this.longitudeController,
    required this.isPrimaryAddress,
    required this.onPrimaryAddressChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionHeader(title: 'Address Details'),
        CustomTextFormField(
          controller: addressController,
          icon: Icons.location_on_outlined,
          label: 'Address',
          hint: 'e.g., 123 Main St, cairo',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: addressLabelController,
          icon: Icons.label_outline,
          label: 'Address Label',
          hint: 'e.g., Home, Work',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: addressAdditionalInfoController,
          icon: Icons.info_outline,
          label: 'Additional Info (Optional)',
          hint: 'e.g., Apt #5, Near the Ain Shams University',
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: latitudeController,
                icon: Icons.explore_outlined,
                label: 'Latitude',
                hint: 'e.g., 34.0522',
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextFormField(
                controller: longitudeController,
                icon: Icons.explore_outlined,
                label: 'Longitude',
                hint: 'e.g., -118.2437',
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomCheckboxField(
          label: 'Set as primary address',
          value: isPrimaryAddress,
          onChanged: onPrimaryAddressChanged,
        ),
      ],
    );
  }
}
