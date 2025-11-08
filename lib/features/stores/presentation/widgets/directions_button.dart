import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';
import 'package:url_launcher/url_launcher.dart'; 

class DirectionsButton extends StatelessWidget {
  final double lat;
  final double long;

  DirectionsButton({
    Key? key,
     required this.lat, required this.long,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.near_me_outlined, size: 18),
        label: const Text('Get Directions'),
        onPressed:() =>context.read<StoreBloc>().add(OpenDirections(lat, long)),

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mediumGrey,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
