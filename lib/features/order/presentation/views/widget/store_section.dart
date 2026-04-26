import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/delivery_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/store_cart.dart';

class StoreSection extends StatelessWidget {
  final AddressStoreState state;
  final String? selectedStoreId;

  const StoreSection({
    super.key,
    required this.state,
    required this.selectedStoreId,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isStoreLoading) return Center(child: buildCompanyShimmerList());
    if (state.storeError != null) return Center(child: Text(state.storeError!));

    final stores = state.stores;
    if (stores.isEmpty) return const Center(child: Text("No stores found"));

    final selectedIndex = selectedStoreId == null
        ? -1
        : stores.indexWhere((store) => store.id == selectedStoreId);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stores.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final store = stores[index];
        return StoreCardOrder(
          index: index,
          selectedValue: selectedIndex,
          store: store,
          onSelect: (value) {
            if (store.id != null) {
              context.read<DeliveryCubit>().selectStore(store.id ?? "");
            }
          },
        );
      },
    );
  }
}
