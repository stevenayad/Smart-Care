import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/stores/data/repositories/store_repository_impl.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';
import 'package:smartcare/features/stores/presentation/widgets/nearest_store_FAB.dart';
import 'package:smartcare/features/stores/presentation/widgets/store_body.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) =>
          StoreBloc(StoreRepositoryImpl(DioConsumer(Dio())))
            ..add(FetchStoresEvent()),
      child: Scaffold(
        body: storeBody(textTheme: textTheme),
        floatingActionButton: const NearestStoreFAB(),
      ),
    );
  }
}
