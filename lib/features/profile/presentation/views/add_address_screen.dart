import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/profile/presentation/views/widget/add_screen_body.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context, 'Add New Address', null, null),
      body: AddScreenBody(),
    );
  }
}
