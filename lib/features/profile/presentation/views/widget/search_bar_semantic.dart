import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/semanticsearch/semanticsearch_cubit.dart';

class SearchBarSemantic extends StatelessWidget {
  const SearchBarSemantic({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    final cubit = BlocProvider.of<SemanticsearchCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFE4EBC8),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black54),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    cubit.getitems(value.trim());
                  }
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.mic_none, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
