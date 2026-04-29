import 'dart:developer';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/http_connection_options.dart';

class DetailsSignalRService {
  static DetailsSignalRService? _instance;

  factory DetailsSignalRService(String token) {
    _instance ??= DetailsSignalRService._internal(token);
    return _instance!;
  }

  DetailsSignalRService._internal(this._token) {
    init();
  }

  String? _token;
  late HubConnection hubConnection;
  void Function(ProductAvailability)? _handler;
  bool _listenerRegistered = false;

  Future<void> updateTokenAndReconnect(String newToken) async {
    if (_token == newToken &&
        hubConnection.state == HubConnectionState.Connected)
      return;

    _token = newToken;
    log("🔄 SignalR Details: Token updated, reconnecting...");

    await disconnect();
    await init();
    await connect();
  }

  Future<void> init() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://smartcarepharmacy.tryasp.net/hubs/products",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => _token ?? "",
          ),
        )
        .withAutomaticReconnect()
        .build();

    if (_handler != null) {
      _listenerRegistered = false;
      listenReservationExpired(_handler!);
    }
  }

  Future<void> disconnect() async {
    if (hubConnection.state != HubConnectionState.Disconnected) {
      try {
        await hubConnection.stop();
        log("❌ SignalR Details Disconnected");
      } catch (e) {
        log("⚠️ SignalR Details Disconnect Error: $e");
      }
    }
  }

  Future<void> connect() async {
    if (hubConnection.state == HubConnectionState.Disconnected) {
      try {
        await hubConnection.start();
        log("✅ SignalR Connected Details");
      } catch (e) {
        log("❌ SignalR Connect Error Details: $e");
      }
    }
  }

  Future<void> joinProductGroup(String productId) async {
    await connect();
    int retries = 10;

    while (hubConnection.state != HubConnectionState.Connected && retries > 0) {
      await Future.delayed(Duration(milliseconds: 150));
      retries--;
    }

    if (hubConnection.state != HubConnectionState.Connected) {
      log("❌ Cannot join , connection still not established Details");
      return;
    }

    try {
      await hubConnection.invoke("JoinProductGroup", args: [productId]);
      log("🟢 Joined Group Details: $productId");
    } catch (e) {
      log("❌ JoinUserGroup Error Details: $e");
    }
  }

  void listenReservationExpired(void Function(ProductAvailability) handler) {
    _handler = handler;

    if (_listenerRegistered) return;
    _listenerRegistered = true;
    log("⚡ LISTENER STARTED Detials");
    hubConnection.on("ProductStockStatusChanged", (data) {
      if (data == null || data.isEmpty) return;
      final first = data.first;
      if (first is! Map<String, dynamic>) return;
      final model = ProductAvailability.fromJson(first);
      log("🔥 Event Triggered Details: productId=${model.productId}");
      _handler?.call(model);
    });
  }
}

class ProductAvailability {
  final String productId;
  final bool isAvailable;

  ProductAvailability({required this.productId, required this.isAvailable});

  factory ProductAvailability.fromJson(Map<String, dynamic> json) {
    return ProductAvailability(
      productId: json['productId'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }
}
