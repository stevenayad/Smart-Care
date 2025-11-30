import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/profile/data/repo/addresses_repository_impl.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_body.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressesBloc(AddressesRepositoryImpl(DioConsumer(Dio()))),
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'My Addresses',
          showBackButton: true,
        ),
        body: AddressBody(),
      ),
    );
  }
}
