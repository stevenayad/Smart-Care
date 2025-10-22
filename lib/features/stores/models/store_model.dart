import 'package:flutter/material.dart';

class Store {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String hours;
  final IconData icon;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.hours,
    required this.icon,
  });
}

final List<Store> dummyStores = [
  Store(
    id: '1',
    name: 'SmartCare Downtown',
    address: '123 Main Street, Downtown',
    phone: '0128123456',
    hours: '8:00 AM - 10:00 PM',
    icon: Icons.local_hospital,
  ),
  Store(
    id: '2',
    name: 'SmartCare Central',
    address: '456 Central Avenue, City Center',
    phone: '0123456789',
    hours: '9:00 AM - 9:00 PM',
    icon: Icons.local_hospital_outlined,
  ),
  Store(
    id: '3',
    name: 'SmartCare North',
    address: '789 North Boulevard, Uptown',
    phone: '0123456789',
    hours: '8:00 AM - 11:00 PM',
    icon: Icons.medical_services,
  ),
];
