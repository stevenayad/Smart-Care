class Store {
  final String name;
  final String address;
  final String phoneNumber;
  final String operatingHours;
  final int stockCount;
  final double distanceInKm;

  const Store({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.operatingHours,
    required this.stockCount,
    required this.distanceInKm,
  });

  bool get isInStock => stockCount > 0;
}

final List<Store> stores = const [
    Store(
      name: 'SmartCare Downtown',
      address: '123 Main Street, Downtown',
      phoneNumber: '+1 (555) 123-4567',
      operatingHours: '8:00 AM - 10:00 PM',
      stockCount: 15,
      distanceInKm: 0.5,
    ),
    Store(
      name: 'SmartCare Central',
      address: '456 Central Avenue, City Center',
      phoneNumber: '+1 (555) 234-5678',
      operatingHours: '9:00 AM - 9:00 PM',
      stockCount: 8,
      distanceInKm: 1.2,
    ),
    Store(
      name: 'SmartCare North',
      address: '789 North Boulevard, Uptown',
      phoneNumber: '+1 (555) 345-6789',
      operatingHours: '8:00 AM - 11:00 PM',
      stockCount: 0, // Out of stock
      distanceInKm: 2.1,
    ),
    Store(
      name: 'SmartCare East',
      address: '321 East Road, Riverside',
      phoneNumber: '+1 (555) 456-7890', // Assuming phone number
      operatingHours: '9:00 AM - 8:00 PM', // Assuming hours
      stockCount: 0, // Out of stock
      distanceInKm: 3.5,
    ),
  ];