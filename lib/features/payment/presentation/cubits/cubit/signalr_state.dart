class PaymentSignalRState {
  final String? orderId;
  final String? status;
  final String? lastMessage;

  PaymentSignalRState({
    this.orderId,
    this.status,
    this.lastMessage,
  });

  PaymentSignalRState copyWith({
    String? orderId,
    String? status,
    String? lastMessage,
  }) {
    return PaymentSignalRState(
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
