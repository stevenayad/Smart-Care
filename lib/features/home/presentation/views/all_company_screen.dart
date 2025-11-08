import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/search/search_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/all_company_body.dart';

class AllCompanyScreen extends StatelessWidget {
  const AllCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepo = HomeRepo(api: DioConsumer(Dio()));

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PaginatedCompanyCubit(homeRepo)..fetchPaginatedCompany(),
          ),
          BlocProvider(
            create: (context) => SearchCubit(homeRepo),
          ),
        ],
        child: const AllCompanyBody(),
      ),
    );
  }
}
