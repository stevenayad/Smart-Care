import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_event.dart';
import 'package:smartcare/features/profile/presentation/views/widget/actions_buttom.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_details.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_row.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});
  final AddressModel address;

  Widget buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!address.isPrimary)
          TextButton(
            onPressed: () {
              context.read<AddressesBloc>().add(
                SetPrimaryAddressEvent(address.id),
              );
            },
            child: const Text('Set as Default'),
          ),
        //TextButton(onPressed: () {}, child: const Text('Edit')),
        TextButton(
          onPressed: () {
            context.read<AddressesBloc>().add(RemoveAddressEvent(address.id));
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }

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
              buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}
