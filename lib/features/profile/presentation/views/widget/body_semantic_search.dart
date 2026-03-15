import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/item_list_view_semantic.dart';
import 'package:smartcare/features/profile/presentation/views/widget/search_bar_semantic.dart';

class BodySemanticSearch extends StatelessWidget {
  const BodySemanticSearch();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 12),
        SearchBarSemantic(),
        SizedBox(height: 16),
        Expanded(child: ItemListViewSemantic()),
      ],
    );
  }
}
