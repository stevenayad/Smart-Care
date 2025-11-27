import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_body.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(
        context,
        'My Addresses',
        onPressed: () {
          Navigator.pop(context);
        },
        actions: null,
      ),
      body: AddressBody(),
    );
  }
}
