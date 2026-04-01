import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/delivery_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/address_section.dart';
import 'package:smartcare/features/order/presentation/views/widget/store_section.dart';
import 'package:smartcare/features/order/presentation/views/widget/tab_button_in_Delivery.dart';

class DeliverySelection extends StatelessWidget {
  const DeliverySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressStoreCubit, AddressStoreState>(
      builder: (context, addressStoreState) {
        return BlocBuilder<DeliveryCubit, DeliveryState>(
          builder: (context, deliveryState) {
            final selectedTab = deliveryState.selectedTab;
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TabButtoninDelvieySelection(
                          title: "Online Delivery",
                          active: selectedTab == 0,
                          onTap: () =>
                              context.read<DeliveryCubit>().selectTab(0),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TabButtoninDelvieySelection(
                          title: "Store Pickup",
                          active: selectedTab == 1,
                          onTap: () =>
                              context.read<DeliveryCubit>().selectTab(1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  selectedTab == 0
                      ? AddressSection(
                          state: addressStoreState,
                          selectedAddressId: deliveryState.selectedAddressId,
                        )
                      : StoreSection(
                          state: addressStoreState,
                          selectedStoreId: deliveryState.selectedStoreId,
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
