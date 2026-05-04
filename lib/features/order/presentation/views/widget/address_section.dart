import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/checkout_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/address_cart.dart';

class AddressSection extends StatelessWidget {
  final AddressStoreState state;

  const AddressSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isAddressLoading) {
      return Center(child: buildCompanyShimmerList());
    }

    if (state.addressError != null) {
      return Center(child: Text(state.addressError!));
    }

    final addresses = state.addresses;

    if (addresses.isEmpty) {
      return const Center(child: Text("No addresses found"));
    }

    return BlocSelector<CheckoutCubit, CheckoutState, int?>(
      selector: (state) => state.selectedAddressIndex,
      builder: (context, selectedIndex) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: addresses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final address = addresses[index];

            return AddressCard(
              index: index,
              selectedValue: selectedIndex ?? -1,
              addressDatum: address,
              onSelect: (index) {
                final selectedAddress = addresses[index];
                context.read<CheckoutCubit>().selectAddress(
                      selectedAddress.id ?? "",
                      index,
                    );
              },
            );
          },
        );
      },
    );
  }
}