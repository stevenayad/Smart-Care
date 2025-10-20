import 'package:flutter/material.dart';
import 'address_type_item.dart';

class AdrressType extends StatefulWidget {
  const AdrressType({super.key});

  @override
  State<AdrressType> createState() => _AdrressTypeState();
}

class _AdrressTypeState extends State<AdrressType> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AddressTypeItem(
          icons: Icons.home,
          text: 'Home',
          isSelected: selectedIndex == 0,
          onTap: () => setState(() => selectedIndex = 0),
        ),
        const SizedBox(width: 8),
        AddressTypeItem(
          icons: Icons.work,
          text: 'Work',
          isSelected: selectedIndex == 1,
          onTap: () => setState(() => selectedIndex = 1),
        ),
        const SizedBox(width: 8),
        AddressTypeItem(
          icons: Icons.location_city,
          text: 'Other',
          isSelected: selectedIndex == 2,
          onTap: () => setState(() => selectedIndex = 2),
        ),
      ],
    );
  }
}
