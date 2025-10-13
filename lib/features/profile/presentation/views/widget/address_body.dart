import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_button.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_list.dart';

class AddressBody extends StatelessWidget {
  const AddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          AddAddressButton(onPressed: null),
          Expanded(child: AddressList()),
        ],
      ),
    );
  }
}
