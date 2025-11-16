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
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/Simple_obsrver.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';
import 'package:smartcare/features/products/data/datasources/categories_remote_data_source.dart';
import 'package:smartcare/features/products/data/datasources/companies_remote_data_source.dart';
import 'package:smartcare/features/products/data/datasources/products_remote_data_source.dart';
import 'package:smartcare/features/stores/data/data_sources/store_remote_data_source.dart';
import 'package:smartcare/features/stores/data/repositories/store_repository_impl.dart';
import 'package:smartcare/features/stores/domain/repositories/store_repository.dart';
import 'package:smartcare/features/products/data/repositories/products_repository_impl.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_event.dart';
import 'package:smartcare/features/products/presentation/bloc/companies/companies_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/companies/companies_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';

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

  final AuthRepository authRepository = AuthRepository(apiConsumer);
  final StoreRemoteDataSourceImpl storeRemoteDataSource =
      StoreRemoteDataSourceImpl(apiConsumer);
  final StoreRepository storeRepository = StoreRepositoryImpl(
    storeRemoteDataSource,
  );

  final productsRemote = ProductsRemoteDataSource(apiConsumer);
  final companiesRemote = CompaniesRemoteDataSource(apiConsumer);
  final categoryRemote = CategoriesRemoteDataSource(apiConsumer);
  final repository = ProductsRepositoryImpl(
    productsRemote,
    companiesRemote,
    categoryRemote,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository)),
        RepositoryProvider<StoreRepository>.value(value: storeRepository),
        BlocProvider(
          create: (context) =>
              FavouriteCubit(DetaisProductRepo(api: DioConsumer(Dio())))
                ..loadFavouriteItems(),
        ),
      ],
      child: SmartCare(repository: repository),
    ),
  );
}

class SmartCare extends StatelessWidget {
  final ProductsRepositoryImpl repository;

  const SmartCare({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductsBloc(repository)..add(const LoadProducts()),
        ),
        BlocProvider(
          create: (context) => CompaniesBloc(repository)..add(LoadCompanies()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(repository)..add(LoadCategories()),
        ),
      ],
      child: MaterialApp(
        title: 'smart care',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppThemes.lightTheme,
        // home:CacheHelper.getAccessToken() != null
        //     ? const HomeScreen()
        //     : const LoginScreen(),
        home: const Mainscreenview(),
      ),
    );
  }
}
