import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/home/data/Repo/details_signalr.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/signalr_details/signalrdetials_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/detailsproduct/detailsproduct_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/rate/rate_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.Productid});
  final String Productid;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartCubit = context.read<CartCubit>();

      if (cartCubit.cartId == null) {
        cartCubit.makecart();
      }
    });

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

          BlocProvider.value(value: context.read<CartCubit>()),

          BlocProvider(
            create: (context) => SignalrdetialsCubit(
              DetailsSignalRService(CacheHelper.getAccessToken()!),
            )..initListener(Productid),
          ),
        ],
        child: DetailsBody(),
      ),
    );
  }
}
