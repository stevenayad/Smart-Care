import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart'
    show CompanyCubit;
import 'package:smartcare/features/home/presentation/cubits/best_seller/best_seller_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiConsumer dioConsumer = DioConsumer(Dio());
    final HomeRepo gategoryrepo = HomeRepo(api: dioConsumer);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CatergoryCubit>(
                create: (context) =>
                    CatergoryCubit(gategoryrepo)..fetchGategory(),
              ),
              BlocProvider<CompanyCubit>(
                create: (context) => CompanyCubit(gategoryrepo)..fetchcomapy(),
              ),
              BlocProvider<BestSellerCubit>(
                create: (context) =>
                    BestSellerCubit(gategoryrepo)..fetchBestSeller(),
              ),
            ],
            child: HomeBody(),
          ),
        ),
      ),
    );
  }
}
