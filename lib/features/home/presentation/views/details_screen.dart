import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/signalr_details/signalrdetials_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/detailsproduct/detailsproduct_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/rate/rate_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_body.dart';
import 'package:smartcare/features/profile/data/repo/semantic_search_repositoy.dart';
import 'package:smartcare/features/profile/presentation/Cubits/simillar/simillarproduct_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.Productid});
  final String Productid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignalrdetialsCubit, SignalrdetialsState>(
      buildWhen: (previous, current) {
        return previous is SignalrdetialsInitial;
      },
      builder: (context, state) {
        context.read<SignalrdetialsCubit>().joinProduct(Productid);

        return Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => FavouriteCubit(
                  DetaisProductRepo(api: DioConsumer(Dio())),
                )..loadFavouriteItems(),
              ),
              BlocProvider(
                create: (context) => DetailsproductCubit(
                  DetaisProductRepo(api: DioConsumer(Dio())),
                )..getproductdetails(Productid),
              ),

              BlocProvider(
                create: (context) =>
                    RateCubit(DetaisProductRepo(api: DioConsumer(Dio())))
                      ..loadUserRate(Productid),
              ),

              BlocProvider(
                create: (context) => SimilarProductsCubit(
                  SemanticSearchRepositoy(api: DioConsumer(Dio())),
                )..getSimilarProducts(Productid),
              ),
            ],
            child: BlocListener<FavouriteCubit, FavouriteState>(
              listener: (context, favState) {
                if (favState is FavouriteSuccess) {
                  // Real-time update for favorites count in profile
                  context.read<Profilecubit>().fetchProfiledata();
                }
              },
              child: DetailsBody(),
            ),
          ),
        );
      },
    );
  }
}
