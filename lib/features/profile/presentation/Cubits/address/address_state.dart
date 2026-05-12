import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressState {
  final int selectedIndex;
  final LatLng? selectedPosition;
  final bool isPrimary;

  AddressState({
    this.selectedIndex = 0,
    this.selectedPosition,
    this.isPrimary = false,
  });

  String get label {
    switch (selectedIndex) {
      case 1:
        return 'Work';
      case 2:
        return 'Other';
      case 0:
      default:
        return 'Home';
    }
  }

  AddressState copyWith({
    int? selectedIndex,
    LatLng? selectedPosition,
    bool? isPrimary,
  }) {
    return AddressState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedPosition: selectedPosition ?? this.selectedPosition,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
