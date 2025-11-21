import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/store_cart.dart';

class StoreSection extends StatefulWidget {
  final AddressStoreState state;
  final ValueChanged<String> onStoreSelect;
  const StoreSection({
    super.key,
    required this.state,
    required this.onStoreSelect,
  });

  @override
  State<StoreSection> createState() => _StoreSectionState();
}

class _StoreSectionState extends State<StoreSection> {
  int selectedStore = -1;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    if (state.isStoreLoading) return Center(child: buildCompanyShimmerList());
    if (state.storeError != null) return Center(child: Text(state.storeError!));

    final stores = state.stores;
    if (stores.isEmpty) return const Center(child: Text("No stores found"));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stores.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final store = stores[index];
        return StoreCardOrder(
          index: index,
          selectedValue: selectedStore,
          store: store,
          onSelect: (value) {
            setState(() => selectedStore = value);
            if (store.id != null) {
              widget.onStoreSelect(store.id!);
            }
          },
        );
      },
    );
  }
}
