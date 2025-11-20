import 'package:flutter/material.dart';
import 'package:smartcare/core/api/services/location_service.dart';
import 'package:smartcare/features/auth/presentation/register/views/map_picker_screen.dart';

enum LocationMethod { current, map }

class LocationPickerRadio extends StatefulWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  const LocationPickerRadio({
    super.key,
    required this.latitudeController,
    required this.longitudeController,
  });

  @override
  State<LocationPickerRadio> createState() => _LocationPickerRadioState();
}

class _LocationPickerRadioState extends State<LocationPickerRadio> {
  LocationMethod? selectedMethod; // nullable to force selection
  bool isLoading = false;

  /// Getter to check if user selected one option
  bool get hasSelected => selectedMethod != null;

  Future<void> _useCurrentLocation() async {
    setState(() => isLoading = true);
    final pos = await LocationService.getCurrentLocation();
    setState(() => isLoading = false);

    if (pos != null) {
      widget.latitudeController.text = pos.latitude.toString();
      widget.longitudeController.text = pos.longitude.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current location detected!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to detect location.")),
      );
    }
  }

  Future<void> _pickFromMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapPickerScreen()),
    );

    if (result != null) {
      widget.latitudeController.text = result.latitude.toString();
      widget.longitudeController.text = result.longitude.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location selected from map!")),
      );
    } else {
      // If user cancels map, revert selection
      setState(() => selectedMethod = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<LocationMethod>(
          value: LocationMethod.current,
          groupValue: selectedMethod,
          title: const Text("Use My Current Location"),
          onChanged: (value) async {
            if (value == null) return;
            setState(() => selectedMethod = value);
            await _useCurrentLocation();
          },
        ),
        RadioListTile<LocationMethod>(
          value: LocationMethod.map,
          groupValue: selectedMethod,
          title: const Text("Select Location From Map"),
          onChanged: (value) async {
            if (value == null) return;
            setState(() => selectedMethod = value);
            await _pickFromMap();
          },
        ),
        if (isLoading) const CircularProgressIndicator(),
      ],
    );
  }
}
