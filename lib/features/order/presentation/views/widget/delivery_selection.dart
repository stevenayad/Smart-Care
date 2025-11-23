import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/address_section.dart';
import 'package:smartcare/features/order/presentation/views/widget/store_section.dart';

class DeliverySelection extends StatefulWidget {
  const DeliverySelection({
    super.key,
    this.onStoreSelected,
    this.onAddressSelected,
    this.onTabChanged,
  });

  final ValueChanged<String?>? onStoreSelected;
  final ValueChanged<String?>? onAddressSelected;
  final ValueChanged<int>? onTabChanged;

  @override
  State<DeliverySelection> createState() => _DeliverySelectionState();
}

class _DeliverySelectionState extends State<DeliverySelection> {
  int selectedTab = 0;
  String? selectedStoreId;
  String? selectedAddressId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressStoreCubit, AddressStoreState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: tabButton(
                      title: "Online Delivery",
                      active: selectedTab == 0,
                      onTap: () {
                        setState(() => selectedTab = 0);
                        widget.onTabChanged?.call(0);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: tabButton(
                      title: "Store Pickup",
                      active: selectedTab == 1,
                      onTap: () {
                        setState(() => selectedTab = 1);
                        widget.onTabChanged?.call(1);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              selectedTab == 0
                  ? AddressSection(
                      state: state,
                      onSelect: (addressId) {
                        setState(() => selectedAddressId = addressId);
                        if (widget.onAddressSelected != null) {
                          widget.onAddressSelected!(addressId);
                        }
                      },
                    )
                  : StoreSection(
                      state: state,
                      onStoreSelect: (storeId) {
                        setState(() => selectedStoreId = storeId);

                        if (widget.onStoreSelected != null) {
                          widget.onStoreSelected!(storeId);
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget tabButton({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF276BFE) : const Color(0xFFF1F3F6),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}