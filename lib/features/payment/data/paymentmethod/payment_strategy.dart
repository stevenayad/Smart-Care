abstract class PaymentStrategy {
    String get providerName; 
  Future<void> pay(String clientSecret);
}