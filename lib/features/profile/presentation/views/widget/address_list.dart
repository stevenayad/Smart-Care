import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> addresses = [
      {
        'id': 1,
        'type': 'Home',
        'isDefault': true,
        'name': 'John Doe',
        'addressLine1': '123 Main Street',
        'addressLine2': 'Apartment 4B',
        'city': 'New York',
        'state': 'NY',
        'zipCode': '10001',
        'country': 'USA',
        'phone': '+1 (555) 123-4567',
        'actions': ['Edit', 'Delete'],
        'icon': Icons.home,
        'color': Colors.blue,
      },
      {
        'id': 2,
        'type': 'Work',
        'isDefault': false,
        'name': 'John Doe',
        'addressLine1': '456 Business Avenue',
        'addressLine2': 'Suite 200',
        'city': 'New York',
        'state': 'NY',
        'zipCode': '10002',
        'country': 'USA',
        'phone': '+1 (555) 123-4567',
        'actions': ['Set as Default', 'Edit', 'Delete'],
        'icon': Icons.work,
        'color': Colors.green,
      },
    ];
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return AddressItem(address: addresses[index]);
      },
    );
  }
}
