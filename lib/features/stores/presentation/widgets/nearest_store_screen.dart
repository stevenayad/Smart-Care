import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';
import 'package:smartcare/features/stores/presentation/widgets/store_card.dart';

class NearestStoreScreen extends StatelessWidget {
  final StoreEntity store;

  const NearestStoreScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearest Store"),
        centerTitle: true,
        elevation: 2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "We've found the nearest store to your location",
              style: theme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Premium card container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: StoreCard(store: store),
            ),

            const Spacer(),

            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Show All Stores"),
              onPressed: () {
                context.read<StoreBloc>().add(FetchStoresEvent());
                Navigator.pop(context); // return to previous screen
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
