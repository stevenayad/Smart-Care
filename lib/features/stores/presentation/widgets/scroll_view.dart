import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/stores/data/models/store_model.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';
import 'package:smartcare/features/stores/presentation/widgets/search_field.dart';
import 'package:smartcare/features/stores/presentation/widgets/store_card.dart';

// Renamed class to follow Dart conventions (UpperCamelCase)
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
          expandedHeight: 130.0,
          backgroundColor: AppColors.primaryblue,

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),

          title: Text(
            'Our Stores',
            style: textTheme.headlineLarge?.copyWith(
              color: AppColors.white,
              fontSize: 22,
            ),
          ),
          centerTitle: true,

          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryblue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${stores.length} locations',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const SearchField(),
                  ],
                ),
              ),
            ),
          ),
          // --- "Smaller" ---
          // The 'bottom' property was removed.
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
