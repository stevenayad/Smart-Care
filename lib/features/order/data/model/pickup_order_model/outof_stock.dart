class OutOfStock {
  final String productId;
  final int requestedQty;
  final int availableQty;

  OutOfStock({
    required this.productId,
    required this.requestedQty,
    required this.availableQty,
  });

  factory OutOfStock.fromJson(Map<String, dynamic> json) {
    return OutOfStock(
      productId: json["productId"],
      requestedQty: json["requestedQty"],
      availableQty: json["availableQty"],
    );
  }
}
