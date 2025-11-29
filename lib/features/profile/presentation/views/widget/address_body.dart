import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_event.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_state.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_button.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_list.dart';

class AddressBody extends StatefulWidget {
  const AddressBody({super.key});

  @override
  State<AddressBody> createState() => _AddressBodyState();
}

class _AddressBodyState extends State<AddressBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressesBloc>().add(GetAddressesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          AddAddressButton(),
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
