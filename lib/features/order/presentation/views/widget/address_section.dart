import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/address_cart.dart';

class AddressSection extends StatefulWidget {
  final AddressStoreState state;
  final ValueChanged<String> onSelect;

  const AddressSection({
    super.key,
    required this.state,
    required this.onSelect,
  });

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  int selectedAddress = -1;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    if (state.isAddressLoading) return Center(child: buildCompanyShimmerList());
    if (state.addressError != null)
      return Center(child: Text(state.addressError!));

    final addresses = state.addresses;
    if (addresses.isEmpty)
      return const Center(child: Text("No addresses found"));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = addresses[index];
        return AddressCard(
          index: index,
          selectedValue: selectedAddress,
          addressDatum: item,
          onSelect: (_) {
            setState(() => selectedAddress = index);
            widget.onSelect(item.id ?? "");
          },
        );
      },
    );
  }
}