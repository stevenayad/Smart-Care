class InventoryModel {
  final String inventoryId;
  final String productId;
  final String storeId;
  final int availableQuantity;
  final String productName;
  final String storeName;
  final String address;
  final String phone;

  InventoryModel({
    required this.inventoryId,
    required this.productId,
    required this.storeId,
    required this.availableQuantity,
    required this.productName,
    required this.storeName,
    required this.address,
    required this.phone,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      inventoryId: json["inventoryId"] ?? "",
      productId: json["productId"] ?? "",
      storeId: json["storeId"] ?? "",
      availableQuantity: json["availableQuantity"] ?? 0,
      productName: json["productName"] ?? "",
      storeName: json["storeName"] ?? "",
      address: json["address"] ?? "",
      phone: json["phone"] ?? "",
    );
  }
}
