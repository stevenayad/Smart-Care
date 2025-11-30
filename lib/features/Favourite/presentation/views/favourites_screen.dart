import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/Favourite/data/favrepoimplemtaion.dart';
import 'package:smartcare/features/Favourite/presentation/cubits/favourite/favoutie_cubit.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/Favourite_body.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.customAppBar(
    title: 'Dashboard',
    showBackButton: true,
    isDarkMode: false, 
  ),
      body: BlocProvider(
        create: (context) =>
            DisplayFavoutieCubit(Favrepoimplemtaion(api: DioConsumer(Dio())))
              ..getitmfav(),
        child: FavouriteBody(),
      ),
    );
  }
}
