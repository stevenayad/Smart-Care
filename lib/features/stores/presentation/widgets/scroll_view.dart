import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/stores/data/models/store_model.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';
import 'package:smartcare/features/stores/presentation/widgets/search_field.dart';
import 'package:smartcare/features/stores/presentation/widgets/store_card.dart';

class scroll_view extends StatelessWidget {
  const scroll_view({super.key, required this.textTheme, required this.stores});

  final TextTheme textTheme;
  final List<StoreEntity> stores;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 160.0,
          backgroundColor: AppColors.primaryblue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 60, bottom: 55),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Stores',
                  style: textTheme.headlineLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 22,
                  ),
                ),
                Text(
                  '${stores.length} locations',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            background: Container(color: AppColors.primaryblue),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: SearchField(),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final store = stores[index];
            return StoreCard(store: store);
          }, childCount: stores.length),
        ),
      ],
    );
  }
}
