import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  final LatLng? initialPosition;
  const MapPickerScreen({super.key, this.initialPosition});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selectedPosition;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Your Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.initialPosition ?? const LatLng(30.0444, 31.2357),
              zoom: 14,
            ),
            onMapCreated: (controller) => mapController = controller,
            onTap: (latLng) {
              setState(() => selectedPosition = latLng);
            },
            markers: selectedPosition != null
                ? {
                    Marker(
                      markerId: const MarkerId("chosen"),
                      position: selectedPosition!,
                    ),
                  }
                : {},
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (selectedPosition != null) {
                  Navigator.pop(context, selectedPosition);
                }
              },
              child: const Text("Select This Location"),
            ),
          ),
        ],
      ),
    );
  }
}
