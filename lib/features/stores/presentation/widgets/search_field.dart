import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_event.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Search stores...',
          prefixIcon: Icon(Icons.search),
          fillColor: AppColors.white,
          filled: true,
        ),
        onChanged: (query) {
          context.read<StoreBloc>().add(SearchStores(query));
        },
      ),
    );
  }
}
