import 'dart:developer';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';

class PaymentSignalr {
  static PaymentSignalr? _instance;

  factory PaymentSignalr(String token) {
    _instance ??= PaymentSignalr._internal(token);
    return _instance!;
  }

  PaymentSignalr._internal(String token) {
    _token = token;
    init();
  }

  String? _token;
  late HubConnection hubConnection;
  void Function(OrderResponse)? _handler;
  String? lastCartId;

  bool _listenerRegistered = false;

  Future<void> init() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://smartcarepharmacy.tryasp.net/hubs/payments",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => _token ?? "",
          ),
        )
        .withAutomaticReconnect()
        .build();

    await connect();

    if (!_listenerRegistered) {
      listenReservationExpired((model) {
        _handler?.call(model);
      });
      _listenerRegistered = true;
    }
  }

  Future<void> connect() async {
    if (hubConnection.state == HubConnectionState.Disconnected) {
      try {
        await hubConnection.start();
        log("✅ SignalR Connected Payment");
      } catch (e) {
        log("❌ SignalR Connect Error: $e");
      }
    }
  }

  void listenReservationExpired(void Function(OrderResponse) handler) {
    _handler = handler;

    if (_listenerRegistered) return;
    _listenerRegistered = true;

    log("⚡ LISTENER STARTED Payment");

    hubConnection.on("PaymentStatusChanged", (data) {
      log("🔥 EVENT TRIGGERED — Raw Data: $data");
      try {
        if (data == null || data.isEmpty) return;
        final first = data.first;
        if (first is! Map<String, dynamic>) return;
        final model = OrderResponse.fromJson(first);
        log(
          "🔔 ReservationExpired => productId=${model.orderId}, qty=${model.status}, msg=${model.message}",
        );
        _handler?.call(model);
      } catch (e, s) {
        log("❌ Error processing ReservationExpired: $e");
        log(s.toString());
      }
    });
  }
}

class OrderResponse {
  final String orderId;
  final String status;
  final String message;

  OrderResponse({
    required this.orderId,
    required this.status,
    required this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orderId: json['orderId'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'orderId': orderId, 'status': status, 'message': message};
  }
}
