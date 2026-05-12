import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/profile/presentation/Cubits/address/address_cubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/add_screen_body.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Add New Address',
        showBackButton: true,
      ),
      body: BlocProvider(
        create: (context) => AddressCubit(),
        child: const AddScreenBody(),
      ),
    );
  }
}
