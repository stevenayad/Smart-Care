import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/auth/data/AuthRep/auth_repository.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/cart/presentation/cubit/signalrcubit/cart_signalr_cubit.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/Simple_obsrver.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  final signalRService = CartSignalRService(CacheHelper.getAccessToken() ?? "");
  await signalRService.init();
  Bloc.observer = SimpleBlocObserver();
  // ✅ Show Flutter errors instead of white screen
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Text(
          "⚠️ UI Error:\n${details.exceptionAsString()}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  };

  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
  final ApiConsumer apiConsumer = DioConsumer(dio);

  final AuthRepository authRepository = AuthRepository(apiConsumer);
  runApp(
    MultiBlocProvider(
      providers: [
      
        BlocProvider(create: (context) => AuthBloc(authRepository)),
        BlocProvider(
          create: (context) =>
              FavouriteCubit(DetaisProductRepo(api: DioConsumer(Dio())))
                ..loadFavouriteItems(),
        ),
      ],
      child: SmartCare(),
    ),
  );
}

class SmartCare extends StatelessWidget {

  const SmartCare({super.key, });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'smart care',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      // home:CacheHelper.getAccessToken() != null
      //     ? const HomeScreen()
      //     : const LoginScreen(),
      home: const LoginScreen(),
    );
  }
}
