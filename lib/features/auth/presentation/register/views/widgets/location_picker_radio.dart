import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcare/core/api/services/location_service.dart';
import 'package:smartcare/features/auth/presentation/register/views/map_picker_screen.dart';

enum LocationMethod { current, map }

class LocationPickerRadio extends StatefulWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  final LocationMethod? selectedMethod;
  final ValueChanged<LocationMethod?> onMethodChanged;

  const LocationPickerRadio({
    super.key,
    required this.latitudeController,
    required this.longitudeController,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  State<LocationPickerRadio> createState() => _LocationPickerRadioState();
}

class _LocationPickerRadioState extends State<LocationPickerRadio> {
  bool isLoading = false;

  /// Getter to check if user selected one option
  bool get hasSelected => widget.selectedMethod != null;

  Future<void> _useCurrentLocation() async {
    setState(() => isLoading = true);
    try {
      final pos = await LocationServiceGelcator.getCurrentLocation();
      setState(() => isLoading = false);

      if (pos != null) {
        widget.latitudeController.text = pos.latitude.toString();
        widget.longitudeController.text = pos.longitude.toString();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Current location detected!")),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to detect location.")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to detect location.")),
      );
    }
  }

  Future<void> _pickFromMap() async {
    setState(() => isLoading = true);
    LatLng? initialPos;
    try {
      final pos = await LocationServiceGelcator.getCurrentLocation();
      if (pos != null) {
        initialPos = LatLng(pos.latitude, pos.longitude);
      }
    } catch (e) {
      // Ignore errors, we can fallback to default location in MapPickerScreen
    }
    setState(() => isLoading = false);
    if (!mounted) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(initialPosition: initialPos),
      ),
    );

    if (result != null) {
      widget.latitudeController.text = result.latitude.toString();
      widget.longitudeController.text = result.longitude.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location selected from map!")),
      );
    } else {
      // If user cancels map, revert selection
      widget.onMethodChanged(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("LocationPickerRadio build: selectedMethod = ${widget.selectedMethod}");
    return Column(
      children: [
        RadioListTile<LocationMethod>(
          value: LocationMethod.current,
          groupValue: widget.selectedMethod,
          title: const Text("Use My Current Location"),
          onChanged: (value) async {
            debugPrint("RadioListTile current onChanged: $value");
            if (value == null) return;
            widget.onMethodChanged(value);
            await _useCurrentLocation();
          },
        ),
        RadioListTile<LocationMethod>(
          value: LocationMethod.map,
          groupValue: widget.selectedMethod,
          title: const Text("Select Location From Map"),
          onChanged: (value) async {
            debugPrint("RadioListTile map onChanged: $value");
            if (value == null) return;
            widget.onMethodChanged(value);
            await _pickFromMap();
          },
        ),
        if (isLoading) const CircularProgressIndicator(),
      ],
    );
  }
}
