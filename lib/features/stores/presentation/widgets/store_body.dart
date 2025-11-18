import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_bloc.dart';
import 'package:smartcare/features/stores/presentation/bloc/store_state.dart';
import 'package:smartcare/features/stores/presentation/widgets/scroll_view.dart';

class storeBody extends StatelessWidget {
  const storeBody({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is StoreLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StoreLoaded) {
          return scroll_view(textTheme: textTheme, stores: state.stores);
        } else if (state is StoreError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
