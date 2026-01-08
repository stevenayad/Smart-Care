import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_bloc.dart';
import 'package:smartcare/features/profile/presentation/blocs/Address%20Bloc/addresses_event.dart';
import 'package:smartcare/features/profile/presentation/views/add_address_screen.dart';

class AddAddressButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddAddressButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions(
        color: Colors.grey,
        strokeWidth: 1,
        dashPattern: const [5, 3],
      ),

      child: InkWell(
        onTap:
            onPressed ??
            () {
              final bloc = context.read<AddressesBloc>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: bloc,
                    child: AddAddressScreen(),
                  ),
                ),
              ).then((_) {
                bloc.add(GetAddressesEvent());
              });
            },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.black, size: 18),
              SizedBox(width: 8),
              Text('Add New Address', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
