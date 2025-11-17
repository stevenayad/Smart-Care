import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/detailsproduct/detailsproduct_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/rate/rate_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_body.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_navagationbar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.Productid});

  final String Productid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DetailsproductCubit(DetaisProductRepo(api: DioConsumer(Dio())))
                  ..getproductdetails(Productid),
          ),
          BlocProvider(
            create: (context) =>
                RateCubit(DetaisProductRepo(api: DioConsumer(Dio())))
                  ..loadUserRate(Productid),
          ),
        ],
        child: DetailsBody(),
      ),
    
    );
  }
}
