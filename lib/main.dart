import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/Favourite/presentation/views/favourites_screen.dart';
import 'package:smartcare/features/auth/data/AuthRep/auth_repository.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/onboarding/presentation/onboardingview.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
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
  final ApiConsumer dioConsumer = DioConsumer(Dio());

  final AuthRepository authRepository = AuthRepository(apiConsumer);
  final HomeRepo gategoryrepo = HomeRepo(api: dioConsumer);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),
        BlocProvider<CatergoryCubit>(
          create: (context) => CatergoryCubit(gategoryrepo)..fetchGategory(),
        ),
        BlocProvider<CompanyCubit>(
          create: (context) => CompanyCubit(gategoryrepo)..fetchcomapy(),
        ),
      ],
      child: const SmartCare(),
    ),
  );
}

class SmartCare extends StatelessWidget {
  const SmartCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Care',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      // home:CacheHelper.getAccessToken() != null
      //     ? const HomeScreen()
      //     : const LoginScreen(),
      home: const Onboardingview(),
    );
  }
}
