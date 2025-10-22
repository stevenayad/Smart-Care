import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/dio_interceptors.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/Favourite/presentation/views/favourites_screen.dart';
import 'package:smartcare/features/auth/data/AuthRep/auth_repository.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/settings/presentation/views/setting_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  final Dio dio = Dio();
  dio.interceptors.add(InterceptorsConsumer());
  final ApiConsumer apiConsumer = DioConsumer(dio);

  final AuthRepository authRepository = AuthRepository(apiConsumer);
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: const SmartCare(),
    ),
  );
}

class SmartCare extends StatelessWidget {
  const SmartCare({super.key});

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
      home: const FavouritesScreen(),
    );
  }
}
