import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/delivery_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/address_cart.dart';

class AddressSection extends StatelessWidget {
  final AddressStoreState state;
  final String? selectedAddressId;

  const AddressSection({
    super.key,
    required this.state,
    required this.selectedAddressId,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isAddressLoading) return Center(child: buildCompanyShimmerList());
    if (state.addressError != null) {
      return Center(child: Text(state.addressError!));
    }

    final addresses = state.addresses;
    if (addresses.isEmpty) {
      return const Center(child: Text("No addresses found"));
    }

    final selectedIndex = selectedAddressId == null
        ? -1
        : addresses.indexWhere((address) => (address.id ?? '') == selectedAddressId);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final address = addresses[index];
        return AddressCard(
          index: index,
          selectedValue: selectedIndex,
          addressDatum: address,
          onSelect: (_) {
            context
                .read<DeliveryCubit>()
                .selectAddress(address.id??"");
          },
        );
      },
    );
  }
}
