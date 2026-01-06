import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/services/location_service.dart';
import 'package:smartcare/features/auth/presentation/register/views/map_picker_screen.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';

class NearestStoreFAB extends StatelessWidget {
  const NearestStoreFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.location_searching),
      onPressed: () {
        _showLocationOptions(context);
      },
    );
  }

  void _showLocationOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.my_location),
                title: const Text("Use My Current Location"),
                onTap: () async {
                  Navigator.pop(context);
                  final pos = await LocationService.getCurrentLocation();
                  if (pos == null) return;

                  context.read<StoreBloc>().add(
                    GetNearestStore(pos.latitude, pos.longitude),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text("Pick From Map"),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MapPickerScreen()),
                  );

                  if (result != null) {
                    context.read<StoreBloc>().add(
                      GetNearestStore(result.latitude, result.longitude),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text("Cancel"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
