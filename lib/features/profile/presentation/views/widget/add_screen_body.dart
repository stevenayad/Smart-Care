import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/auth/presentation/register/views/map_picker_screen.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_event.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_state.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_type.dart';
import 'package:smartcare/features/profile/presentation/views/widget/city_zip.dart';
import 'package:smartcare/features/profile/presentation/views/widget/custom_text_feild.dart';

class AddScreenBody extends StatefulWidget {
  const AddScreenBody({super.key});

  @override
  State<AddScreenBody> createState() => _AddScreenBodyState();
}

class _AddScreenBodyState extends State<AddScreenBody> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  int selectedIndex = 0; // 0: Home, 1: Work, 2: Other
  LatLng? selectedPosition;
  bool isPrimary = false;

  @override
  void dispose() {
    labelController.dispose();
    fullNameController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String getLabelFromIndex(int idx) {
    switch (idx) {
      case 1:
        return 'Work';
      case 2:
        return 'Other';
      case 0:
      default:
        return 'Home';
    }
  }

  bool validate() {
    return labelController.text.trim().isNotEmpty &&
        streetController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        zipController.text.trim().isNotEmpty &&
        selectedPosition != null;
  }

  void onSave() {
    if (!validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill required fields and pick a location'),
        ),
      );
      return;
    }

    final addressModel = AddressModel(
      id: '', // server will assign id
      address: streetController.text.trim(),
      label: labelController.text.trim(),
      additionalInfo:
          '${cityController.text.trim()}, ${zipController.text.trim()}',
      latitude: selectedPosition!.latitude,
      longitude: selectedPosition!.longitude,
      isPrimary: isPrimary,
    );

    context.read<AddressesBloc>().add(AddAddressEvent(addressModel));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressesBloc, dynamic>(
      listener: (context, state) {
        if (state is AddressesAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Address added successfully')),
          );
          Navigator.of(context).pop(true);
        }
        if (state is AddressesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Address Type',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 4),
              const AdrressType(),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Address Label',
                icon: Icons.label_outline,
                controller: labelController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Full Name',
                icon: Icons.person_outline,
                controller: fullNameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Street Address',
                icon: Icons.streetview,
                controller: streetController,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              CityZip(
                cityController: cityController,
                zipController: zipController,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push<LatLng?>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MapPickerScreen(),
                        ),
                      );
                      if (result != null) {
                        setState(() => selectedPosition = result);
                      }
                    },
                    icon: const Icon(Icons.pin_drop),
                    label: Text(
                      selectedPosition == null
                          ? 'Pick Location'
                          : 'Location Selected',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Checkbox(
                    value: isPrimary,
                    onChanged: (v) => setState(() => isPrimary = v ?? false),
                  ),
                  const Text('Set as primary'),
                ],
              ),
              const SizedBox(height: 30),

              BlocBuilder<AddressesBloc, dynamic>(
                builder: (context, state) {
                  final isLoading = state is AddressesLoading;
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: isLoading ? null : onSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLightColor,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    'Save Address',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha:  0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
