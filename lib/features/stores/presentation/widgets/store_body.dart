import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_state.dart';
import 'package:smartcare/features/stores/presentation/widgets/scroll_view.dart';
import 'package:smartcare/features/stores/presentation/widgets/store_card.dart'
    show StoreCard;

class storeBody extends StatelessWidget {
  const storeBody({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is StoreLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StoreLoaded) {
          return scroll_view(textTheme: textTheme, stores: state.stores);
        } else if (state is StoreError) {
          return Center(child: Text(state.message));
        } else if (state is NearestStoreLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We've found the nearest store to your location",
                style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Center(child: StoreCard(store: state.store)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text("Show All Stores"),
                  onPressed: () {
                    context.read<StoreBloc>().add(FetchStoresEvent());
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
