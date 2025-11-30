import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/cart/presentation/cubit/signalrcubit/cart_signalr_cubit.dart';
import 'package:smartcare/features/cart/presentation/views/widget/cart_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<CartCubit>()),
        // BlocProvider.value(value: context.read<CartCubit>()),
      ],
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errmessage),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: customappbar(
            context,
            'My Cart',
            onPressed: () => Navigator.pop(context),
          ),
          body: Column(children: [Expanded(child: CartBody())]),
        ),
      ],
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'My Cart',
          showBackButton: true,
          isDarkMode: false,
        ),
        body: Column(children: [Expanded(child: CartBody())]),
      ),
    );
  }
}
