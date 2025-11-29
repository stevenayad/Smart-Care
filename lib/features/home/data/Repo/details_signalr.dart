import 'dart:developer';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/http_connection_options.dart';

class DetailsSignalRService {
  String? _token;
  late HubConnection hubConnection;
  void Function(ProductAvailability)? _handler;
  bool _listenerRegistered = false;

  DetailsSignalRService(String token) {
    _token = token;
    init();
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
