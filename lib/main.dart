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
import 'package:smartcare/features/onboarding/presentation/onboardingview.dart';
import 'package:smartcare/features/products/data/datasources/categories_remote_data_source.dart';

import 'package:smartcare/features/products/data/datasources/companies_remote_data_source.dart';
import 'package:smartcare/features/products/data/datasources/products_remote_data_source.dart';

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
  final Dio dio = Dio();
  dio.interceptors.add(InterceptorsConsumer());
  final ApiConsumer apiConsumer = DioConsumer(dio);

  final AuthRepository authRepository = AuthRepository(apiConsumer);
  final productsRemote = ProductsRemoteDataSource(apiConsumer);
  final companiesRemote = CompaniesRemoteDataSource(apiConsumer);
  final categoryRemote = CategoriesRemoteDataSource(apiConsumer);
  final repository = ProductsRepositoryImpl(productsRemote, companiesRemote,categoryRemote);

  

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: SmartCare(repository: repository,),
    ),
  );
}

class SmartCare extends StatelessWidget {
  final ProductsRepositoryImpl repository;

  const SmartCare({super.key, required this.repository,
});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
            create: (context) => ProductsBloc(repository)..add(const LoadProducts()),
          ),
          BlocProvider(
            create: (context) => CompaniesBloc(repository)..add(LoadCompanies()),
            
          ),
          BlocProvider(create: 
          (context)=>CategoryBloc(repository)..add(LoadCategories())
          )
          
        
      ],
      child: MaterialApp(
        title: 'smart care',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppThemes.lightTheme,
        // home:CacheHelper.getAccessToken() != null
        //     ? const HomeScreen()
        //     : const LoginScreen(),
        home: const LoginScreen(),
      ),
    );
  }
}
