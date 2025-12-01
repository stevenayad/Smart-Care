import 'dart:developer';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/http_connection_options.dart';

class AppSignalRService {
  static AppSignalRService? _instance;

  factory AppSignalRService(String token) {
    _instance ??= AppSignalRService._internal(token);
    return _instance!;
  }

  AppSignalRService._internal(this._token);

  final String? _token;
  late HubConnection hubConnection;

  bool _connected = false;
  bool _listenersRegistered = false;

  void Function(ReservationExpiredModel)? onCartReservationExpired;
  void Function(OrderResponse)? onPaymentStatusChanged;

  Future<void> init() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://smartcarepharmacy.tryasp.net/hubs/users",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => _token ?? "",
          ),
        )
        .withAutomaticReconnect()
        .build();

    await connect();

    if (!_listenersRegistered) {
      _registerListeners();
      _listenersRegistered = true;
    }
  }

  Future<void> connect() async {
    if (!_connected && hubConnection.state == HubConnectionState.Disconnected) {
      try {
        await hubConnection.start();
        _connected = true;
        log("✅ SignalR Connected");
      } catch (e) {
        log("❌ SignalR Connect Error: $e");
      }
    }
  }

  Future<void> disconnect() async {
    if (_connected) {
      await hubConnection.stop();
      _connected = false;
      log("❌ SignalR Disconnected");
    }
  }

  void _registerListeners() {
    log('Singal Listser');
    hubConnection.on("ReservationExpired", (data) {
      try {
        if (data == null || data.isEmpty) return;
        final first = data.first;
        if (first is! Map<String, dynamic>) return;
        final model = ReservationExpiredModel.fromJson(first);
        log(
          "🔔 ReservationExpired => productId=${model.productId}, qty=${model.quantity}, msg=${model.message}",
        );
        onCartReservationExpired?.call(model);
      } catch (e, s) {
        log("❌ Error processing ReservationExpired: $e");
        log(s.toString());
      }
    });

    hubConnection.on("PaymentStatusChanged", (data) {
      try {
        if (data == null || data.isEmpty) return;
        final first = data.first;
        if (first is! Map<String, dynamic>) return;
        final model = OrderResponse.fromJson(first);
        log(
          "🔔 ReservationExpired => productId=${model.message}, qty=${model.orderId}, msg=${model.status}",
        );
        onPaymentStatusChanged?.call(model);
      } catch (e, s) {
        log("❌ Error processing PaymentStatusChanged: $e");
        log(s.toString());
      }
    });
  }
}

class ReservationExpiredModel {
  String? productId;
  int? quantity;
  String? message;

  ReservationExpiredModel({this.productId, this.quantity, this.message});

  factory ReservationExpiredModel.fromJson(Map<String, dynamic> json) {
    return ReservationExpiredModel(
      productId: json['productId'] as String?,
      quantity: json['quantity'] as int?,
      message: json['message'] as String?,
    );
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
