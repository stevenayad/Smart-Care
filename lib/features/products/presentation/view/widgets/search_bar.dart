import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
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
            colors: [
              colorScheme.primary.withValues(alpha: 0.8),
              colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          buildWhen: (p, c) =>
              p.searchAxis != c.searchAxis ||
              p.searchAxisLabel != c.searchAxisLabel,
          builder: (context, state) {
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton<ProductsSearchAxis>(
                    value: state.searchAxis,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: ProductsSearchAxis.name,
                        child: Text('Name'),
                      ),
                      DropdownMenuItem(
                        value: ProductsSearchAxis.company,
                        child: Text('Company'),
                      ),
                      DropdownMenuItem(
                        value: ProductsSearchAxis.category,
                        child: Text('Category'),
                      ),
                      DropdownMenuItem(
                        value: ProductsSearchAxis.description,
                        child: Text('Description'),
                      ),
                    ],
                    onChanged: (axis) {
                      if (axis == null) {
                        return;
                      }
                      context.read<ProductsBloc>().add(
                        ProductSearchAxisChanged(axis),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    onChanged: (value) => context.read<ProductsBloc>().add(
                      ProductSearchInputChanged(value),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search by ${state.searchAxisLabel}...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
