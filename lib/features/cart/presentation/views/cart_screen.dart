import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/cart/presentation/cubit/signalrcubit/cart_signalr_cubit.dart';
import 'package:smartcare/features/cart/presentation/views/widget/cart_appbar.dart';
import 'package:smartcare/features/cart/presentation/views/widget/cart_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signalRService = CartSignalRService(CacheHelper.getAccessToken()!);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          lazy: false,
          create: (context) {
            final cubit = CartCubit(
              cartrepo: Cartrepo(apiConsumer: DioConsumer(Dio())),
              signalRService: signalRService,
            );

            cubit.GetITem(cubit.cartId ?? "");

            return cubit;
          },
        ),

        BlocProvider<CartSignalRCubit>(
          lazy: false,
          create: (ctx) => CartSignalRCubit(
            signalRService: signalRService,
            cartCubit: ctx.read<CartCubit>(),
          ),
        ),
      ],
      child: const Scaffold(
        appBar: CartAppBar(),
        body: Column(children: [Expanded(child: CartBody())]),
      ),
    );
  }
}
