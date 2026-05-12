import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/address/address_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/address/address_state.dart';
import 'address_type_item.dart';

class AdrressType extends StatelessWidget {
  const AdrressType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddressTypeItem(
              icons: Icons.home,
              text: 'Home',
              isSelected: state.selectedIndex == 0,
              onTap: () => context.read<AddressCubit>().updateIndex(0),
            ),
            const SizedBox(width: 8),
            AddressTypeItem(
              icons: Icons.work,
              text: 'Work',
              isSelected: state.selectedIndex == 1,
              onTap: () => context.read<AddressCubit>().updateIndex(1),
            ),
            const SizedBox(width: 8),
            AddressTypeItem(
              icons: Icons.location_city,
              text: 'Other',
              isSelected: state.selectedIndex == 2,
              onTap: () => context.read<AddressCubit>().updateIndex(2),
            ),
          ],
        );
      },
    );
  }
}
