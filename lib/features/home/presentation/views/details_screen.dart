import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/detailsproduct/detailsproduct_cubit.dart';

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
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            DetailsproductCubit(DetaisProductRepo(api: DioConsumer(Dio())))
              ..getproductdetails(Productid),
        child: DetailsBody(),
      ),
      bottomNavigationBar: DetailsNavagationbar(),
    );
  }
}
