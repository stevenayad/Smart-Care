import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_event.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_state.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_button.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_list.dart';

class AddressBody extends StatelessWidget {
  const AddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const AddAddressButton(),
          Expanded(
            child: BlocBuilder<AddressesBloc, AddressesState>(
              builder: (context, state) {
                if (state is AddressesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AddressesError) {
                  return Center(child: Text(state.message));
                }
                if (state is AddressesLoaded) {
                  return AddressList(addresses: state.addresses);
                }
                if (state is AddressRemoved) {
                  context.read<AddressesBloc>().add(GetAddressesEvent());
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SetPrimaryAddress) {
                  context.read<AddressesBloc>().add(GetAddressesEvent());
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AddressesInitial) return const SizedBox.shrink();
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
