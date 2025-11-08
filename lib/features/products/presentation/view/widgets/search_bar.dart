import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/products/products_bloc.dart';
import '../../bloc/products/products_event.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _ctrl = TextEditingController();
  String _searchType = 'Name';

  void _onSearch() {
    final q = _ctrl.text.trim();

    if (q.isEmpty) {
      context.read<ProductsBloc>().add(const LoadProducts());
      return;
    }

    final bloc = context.read<ProductsBloc>();

    switch (_searchType) {
      case 'Company':
        bloc.add(SearchProductsByCompanyName(q));
        break;
      case 'Category':
        bloc.add(SearchProductsByCategoryName(q));
        break;
      case 'Description':
        bloc.add(SearchProductsByDescription(q));
        break;
      default:
        bloc.add(SearchProducts(q));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          DropdownButton<String>(
            value: _searchType,
            borderRadius: BorderRadius.circular(12),
            items: const [
              DropdownMenuItem(value: 'Name', child: Text('Name')),
              DropdownMenuItem(value: 'Company', child: Text('Company')),
              DropdownMenuItem(value: 'Category', child: Text('Category')),
              DropdownMenuItem(
                value: 'Description',
                child: Text('Description'),
              ),
            ],
            onChanged: (val) => setState(() => _searchType = val!),
          ),
          const SizedBox(width: 8),

          // Search TextField
          Expanded(
            child: TextField(
              controller: _ctrl,
              onSubmitted: (_) => _onSearch(),
              decoration: InputDecoration(
                hintText: 'Search by $_searchType...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(width: 8),

          ElevatedButton.icon(
            onPressed: _onSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(Icons.search, size: 18),
            label: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
