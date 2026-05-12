import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/auth/presentation/register/views/map_picker_screen.dart';
import 'package:smartcare/features/profile/presentation/Cubits/address/address_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/address/address_state.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_state.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_type.dart';
import 'package:smartcare/features/profile/presentation/views/widget/city_zip.dart';
import 'package:smartcare/features/profile/presentation/views/widget/custom_text_feild.dart';

class AddScreenBody extends StatelessWidget {
  const AddScreenBody({super.key});

  void onSave(BuildContext context) {
    final cubit = context.read<AddressCubit>();
    if (!cubit.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill required fields and pick a location'),
        ),
      );
      return;
    }
    cubit.onSave(context.read<AddressesBloc>());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressCubit>();
    return BlocListener<AddressesBloc, AddressesState>(
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
                label: 'Full Name',
                icon: Icons.person_outline,
                controller: cubit.fullNameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Street Address',
                icon: Icons.streetview,
                controller: cubit.streetController,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              CityZip(
                cityController: cubit.cityController,
                zipController: cubit.zipController,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  return Row(
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
                            cubit.updatePosition(result);
                          }
                        },
                        icon: const Icon(Icons.pin_drop),
                        label: Text(
                          state.selectedPosition == null
                              ? 'Pick Location'
                              : 'Location Selected',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Checkbox(
                        value: state.isPrimary,
                        onChanged: (v) => cubit.togglePrimary(v ?? false),
                      ),
                      const Text('Set as primary'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<AddressesBloc, AddressesState>(
                builder: (context, state) {
                  final isLoading = state is AddressesLoading;
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: isLoading ? null : () => onSave(context),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.7),
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
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
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
