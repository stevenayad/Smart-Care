import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_event.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final fullNameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();

  AddressCubit() : super(AddressState());

  @override
  Future<void> close() {
    fullNameController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipController.dispose();
    phoneController.dispose();
    return super.close();
  }

  void updateIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void updatePosition(LatLng position) {
    emit(state.copyWith(selectedPosition: position));
  }

  void togglePrimary(bool value) {
    emit(state.copyWith(isPrimary: value));
  }

  bool validate() {
    return streetController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        zipController.text.trim().isNotEmpty &&
        state.selectedPosition != null;
  }

  void onSave(AddressesBloc addressesBloc) {
    final addressModel = AddressModel(
      id: '',
      address: streetController.text.trim(),
      label: state.label,
      additionalInfo:
          '${cityController.text.trim()}, ${zipController.text.trim()}',
      latitude: state.selectedPosition!.latitude,
      longitude: state.selectedPosition!.longitude,
      isPrimary: state.isPrimary,
    );

    addressesBloc.add(AddAddressEvent(addressModel));
  }
}
