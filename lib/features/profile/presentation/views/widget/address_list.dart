import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_item.dart';

class AddressList extends StatelessWidget {
  final List<AddressModel> addresses;
  const AddressList({super.key, this.addresses = const []});

  @override
  Widget build(BuildContext context) {
  if (addresses.isEmpty) return const Center(child: Text('No addresses yet'));
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return AddressItem(address: addresses[index]);
      },
    );
  }
}
