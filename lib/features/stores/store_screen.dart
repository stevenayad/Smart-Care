import 'package:flutter/material.dart';
import 'package:smartcare/features/stores/widgets/scroll_view.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: scroll_view(textTheme: textTheme),
    );
  }
}
