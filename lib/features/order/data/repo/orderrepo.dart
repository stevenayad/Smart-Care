import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/order/data/model/address_model/address_model.dart';
import 'package:smartcare/features/order/data/model/create_order_model/create_order_model.dart';
import 'package:smartcare/features/order/data/model/order_details/order_details..dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/pickup_order_model.dart';
import 'package:smartcare/features/order/data/model/request_createoreder.dart';
import 'package:smartcare/features/order/data/model/request_pickup.dart';
import 'package:smartcare/features/order/data/model/requestupdateorder.dart';
import 'package:smartcare/features/order/data/model/store_model/store_model.dart';
import 'package:smartcare/features/order/data/model/udateorder/udateorder.dart';

abstract class Orderrepo {
  Future<Either<Failure, StoreOrderModel>> getstore();
  Future<Either<Failure, AddressModel>> getaddress();
  Future<Either<Failure, PickupOrderModel>> pickuporder(
    RequestPickup request,
  );
  Future<Either<Failure, CreateOrderModel>> createorder(
    RequestCreateoreder request,
  );
  Future<Either<Failure, Updateorder>> updateorder(
    RequestUpdateOrder request,
  );
  Future<Either<Failure, OrderDetails>> fetchOrderDetails(String id);
}