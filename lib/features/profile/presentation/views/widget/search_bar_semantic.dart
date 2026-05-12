import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/semanticsearch/semanticsearch_cubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/voice_record.dart';

class SearchBarSemantic extends StatefulWidget {
  const SearchBarSemantic({
    super.key,
    required this.initialQuery,
  });

  final String initialQuery;

  @override
  State<SearchBarSemantic> createState() => _SearchBarSemanticState();
}

class _SearchBarSemanticState extends State<SearchBarSemantic> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.initialQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            const Icon(Icons.search, color: Colors.black54),
            const SizedBox(width: 8),

            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    cubit.getitems(value.trim());
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),

            VoiceRecorderWidget(
              onAudioRecorded: (path) {
                context.read<SemanticsearchCubit>().getitemsbyvoice(path);
              },
              onTextRecognized: (text) {
                _searchController.text = text;
                context.read<SemanticsearchCubit>().getitems(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}