import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/products/products_bloc.dart';
import '../../bloc/products/products_event.dart';
import 'dart:async';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _ctrl = TextEditingController();
  String _searchType = 'Name';
  Timer? _debounce;

  void _onSearch(String query) {
    final q = query.trim();
    final bloc = context.read<ProductsBloc>();

    if (q.isEmpty) {
      bloc.add(const LoadProducts());
      return;
    }

    switch (_searchType) {
      case 'Company':
        bloc.add(SearchProductsByCompanyName(q, 1, 10));
        break;
      case 'Category':
        bloc.add(SearchProductsByCategoryName(q, 1, 10));
        break;
      case 'Description':
        bloc.add(SearchProductsByDescription(q, 1, 10));
        break;
      default:
        bloc.add(SearchProducts(q, 1, 10));
    }
  }

  void _onChanged(String value) {
    // Debounce to prevent too many calls
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _onSearch(value);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary.withValues(alpha: 0.8), colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            // Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                value: _searchType,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'Name', child: Text('Name')),
                  DropdownMenuItem(value: 'Company', child: Text('Company')),
                  DropdownMenuItem(value: 'Category', child: Text('Category')),
                  DropdownMenuItem(value: 'Description', child: Text('Description')),
                ],
                onChanged: (val) => setState(() => _searchType = val!),
              ),
            ),
            const SizedBox(width: 12),

            // Search TextField
            Expanded(
              child: TextField(
                controller: _ctrl,
                onChanged: _onChanged, 
                decoration: InputDecoration(
                  hintText: 'Search by $_searchType...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
