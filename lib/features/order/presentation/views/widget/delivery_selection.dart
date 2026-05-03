import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/checkout_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/address_section.dart';
import 'package:smartcare/features/order/presentation/views/widget/store_section.dart';
import 'package:smartcare/features/order/presentation/views/widget/tab_button_in_Delivery.dart';

class DeliverySelection extends StatelessWidget {
  const DeliverySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const SizedBox(height: 12),

          BlocSelector<CheckoutCubit, CheckoutState, int>(
            selector: (state) => state.selectedTab,
            builder: (context, selectedTab) {
              return Row(
                children: [
                  Expanded(
                    child: TabButtoninDelvieySelection(
                      title: "Online Delivery",
                      active: selectedTab == 0,
                      onTap: () => context.read<CheckoutCubit>().selectTab(0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TabButtoninDelvieySelection(
                      title: "Store Pickup",
                      active: selectedTab == 1,
                      onTap: () => context.read<CheckoutCubit>().selectTab(1),
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          BlocSelector<CheckoutCubit, CheckoutState, int>(
            selector: (state) => state.selectedTab,
            builder: (context, selectedTab) {
              return BlocListener<AddressStoreCubit, AddressStoreState>(
                listener: (context, addressStoreState) {
                  if (addressStoreState.addresses.isNotEmpty) {
                    context
                        .read<CheckoutCubit>()
                        .initAddresses(addressStoreState.addresses);
                  }
                },
                child: BlocBuilder<AddressStoreCubit, AddressStoreState>(
                  builder: (context, addressStoreState) {
                    if (selectedTab == 0) {
                      return AddressSection(
                        state: addressStoreState,
                      );
                    } else {
                      return BlocSelector<CheckoutCubit, CheckoutState, String?>(
                        selector: (state) => state.selectedStoreId,
                        builder: (context, selectedStoreId) {
                          return StoreSection(
                            state: addressStoreState,
                            selectedStoreId: selectedStoreId,
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
