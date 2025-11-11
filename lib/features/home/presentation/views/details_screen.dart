import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/detailsproduct/detailsproduct_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/rate/rate_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_body.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_navagationbar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.Productid});

  final String Productid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(
        context,
        'Product Details',
        () {
          Navigator.pop(context);
        },
        [
          BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<FavouriteCubit>(context);
              final isFav = cubit.isFavourite(Productid);
              return IconButton(
                onPressed: () {
                  cubit.toggleFavItem(Productid);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? 'Removed from favourites'
                            : 'Added to favourites',
                      ),
                      backgroundColor: isFav ? Colors.red : Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.black,
                ),
              );
            },
          ),

          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DetailsproductCubit(DetaisProductRepo(api: DioConsumer(Dio())))
                  ..getproductdetails(Productid),
          ),
           BlocProvider(
            create: (context) =>
                RateCubit(DetaisProductRepo(api: DioConsumer(Dio())))..loadUserRate(Productid),
                
                 
          ),
          
        ],
        child: DetailsBody(),
      ),
      bottomNavigationBar: DetailsNavagationbar(),
    );
  }
}
