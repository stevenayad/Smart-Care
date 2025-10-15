import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/profile/presentation/views/widget/actions_buttom.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_details.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_row.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});
  final Map<String, dynamic> address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secondaryLightColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressRow(address: address),
              const SizedBox(height: 12),
              AddressDetails(address: address),
              Divider(thickness: 0.5),
              buildActionButtons(address['actions'], context),
            ],
          ),
        ),
      ),
    );
  }
}
