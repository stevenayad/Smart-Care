import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/profile/data/repo/semantic_search_repositoy.dart';
import 'package:smartcare/features/profile/presentation/Cubits/semanticsearch/semanticsearch_cubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/body_semantic_search.dart';

class SemanticSearchScreen extends StatelessWidget {
  const SemanticSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SemanticsearchCubit(
        searchRepositoy: SemanticSearchRepositoy(api: DioConsumer(Dio())),
      ),
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'Find Your Medicine',
          showBackButton: true,
        ),
        backgroundColor: const Color(0xFFF8F9EC),
        body: const SafeArea(child: BodySemanticSearch()),
      ),
    );
  }
}
