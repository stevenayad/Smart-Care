import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';

class CallButton extends StatelessWidget {
  // final VoidCallback onPressed;
  final String phoneNumber;

  const CallButton({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.phone_outlined, size: 18),
        label: const Text('Call Store'),
        onPressed: () => context.read<StoreBloc>().add(CallStore(phoneNumber)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mediumGrey,
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
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
