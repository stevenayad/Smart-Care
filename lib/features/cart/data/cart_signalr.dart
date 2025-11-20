import 'dart:developer';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/http_connection_options.dart';

class CartSignalRService {
  static CartSignalRService? _instance;

  factory CartSignalRService(String token) {
    _instance ??= CartSignalRService._internal(token);
    return _instance!;
  }

  CartSignalRService._internal(String token) {
    _token = token;
    init();
  }

  String? _token;
  late HubConnection hubConnection;
  void Function(ReservationExpiredModel)? _handler;
  String? lastCartId;

  bool _listenerRegistered = false;

  Future<void> init() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://smartcarepharmacy.tryasp.net/hubs/cart",
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
        log("✅ SignalR Connected");
      } catch (e) {
        log("❌ SignalR Connect Error: $e");
      }
    }
  }
  
  Future<void> joinUserGroup(String cartId) async {
    lastCartId = cartId;
    await connect();

    int retries = 5;
    while (hubConnection.state != HubConnectionState.Connected && retries > 0) {
      log("⏳ Waiting for connection… Current State: ${hubConnection.state}");
      await Future.delayed(const Duration(milliseconds: 200));
      retries--;
    }

    if (hubConnection.state != HubConnectionState.Connected) {
      log("❌ Cannot join, connection still not established");
      return;
    }

    try {
      await hubConnection.invoke("JoinCartGroup", args: [cartId]);
      log("🟢 Joined Group: $cartId");
    } catch (e) {
      log("❌ JoinUserGroup Error: $e");
    }
  }

  void listenReservationExpired(void Function(ReservationExpiredModel) handler) {
    _handler = handler;

    if (_listenerRegistered) return;
    _listenerRegistered = true;

    log("⚡ LISTENER STARTED");

    hubConnection.on("ReservationExpired", (data) {
      log("🔥 EVENT TRIGGERED — Raw Data: $data");
      try {
        if (data == null || data.isEmpty) return;
        final first = data.first;
        if (first is! Map<String, dynamic>) return;
        final model = ReservationExpiredModel.fromJson(first);
        log("🔔 ReservationExpired => productId=${model.productId}, qty=${model.quantity}, msg=${model.message}");
        _handler?.call(model);
      } catch (e, s) {
        log("❌ Error processing ReservationExpired: $e");
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
