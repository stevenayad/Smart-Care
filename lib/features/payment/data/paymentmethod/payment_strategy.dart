abstract class PaymentStrategy {
  Future<void> pay(String clientSecret);
}