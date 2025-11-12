import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/views/all_company_screen.dart';

class CommonSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final VoidCallback? onViewAllTap;
  final isbestseller_favourotiteite;
  const CommonSection({
    super.key,
    required this.title,
    required this.items,
    this.onViewAllTap,
    required this.isbestseller_favourotiteite,
  });

  @override
  Widget build(BuildContext context) {
    final viewAllStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: Colors.black54);
    final titlestyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 16.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: titlestyle),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CompanyWithProductsScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('View All', style: viewAllStyle),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: isbestseller_favourotiteite ? 210 : 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return items[index];
            },
          ),
        ),
      ],
    );
  }
}
