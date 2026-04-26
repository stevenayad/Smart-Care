import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/core/token_storage.dart';
import 'package:smartcare/features/auth/data/AuthRep/auth_repository.dart';
import 'package:smartcare/features/auth/presentation/Manager/request_bloc/request_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/auth_cubit/authcubit_cubit.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart'
    show LoginScreen;
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/cart/presentation/cubit/signalrcubit/cart_signalr_cubit.dart';
import 'package:smartcare/features/home/data/Repo/details_signalr.dart';
import 'package:smartcare/features/home/presentation/cubits/Simple_obsrver.dart';
import 'package:smartcare/features/home/presentation/cubits/signalr_details/signalrdetials_cubit.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Stripe
  Stripe.publishableKey =
      "pk_test_51REy0EFRp5Zs3XNLj1aEXrZT4rEJedhD1I3zReXqqS9gweVetdESHEvutDhaLIporP6gO2GIMyGxVsCTLfzFRWn300Zeb5Rrz7";

  /// Cache
  await CacheHelper.init();

  /// Bloc Observer
  Bloc.observer = SimpleBlocObserver();

  runApp(const SmartCare());
}

class SmartCare extends StatelessWidget {
  const SmartCare({super.key});

  @override
  Widget build(BuildContext context) {
    final signalRService = AppSignalRService(
      CacheHelper.getAccessToken() ?? "",
    );

    final apiConsumer = DioConsumer(Dio());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignalrdetialsCubit(
            DetailsSignalRService(CacheHelper.getAccessToken()!),
          )..initGlobalListener(),
        ),

        /// Auth
        BlocProvider(create: (_) => AuthBloc(AuthRepository(apiConsumer))),

        /// Order
        BlocProvider(
          create: (_) => OrderCubit(Orderrepo(apiConsumer: apiConsumer)),
        ),

        /// Cart
        BlocProvider(
          create: (_) => CartCubit(
            cartrepo: Cartrepo(apiConsumer: apiConsumer),
            signalRService: signalRService,
          ),
        ),

        /// Cart SignalR (lazy default = true)
        BlocProvider(
          create: (ctx) => CartSignalRCubit(
            signalRService: signalRService,
            cartCubit: ctx.read<CartCubit>(),
          ),
        ),

        /// Profile (Global to allow real-time cross-app updates)
        BlocProvider(
          create: (_) =>
              Profilecubit(ProfileRepoimplemtation(api: apiConsumer)),
        ),

        BlocProvider(create: (_) => AuthCubit(TokenStorage())..checkAuth()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Smart Care",
        theme: AppThemes.lightTheme,
        themeMode: ThemeMode.system,
        home: const LoginScreen(),
      ),
    );
  }
}
