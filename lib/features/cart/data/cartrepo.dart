import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/cart/data/model/add_item_cart_model/add_item_cart_model.dart';
import 'package:smartcare/features/cart/data/model/create_cart_model.dart';
import 'package:smartcare/features/cart/data/model/items_cart/items_cart.dart';
import 'package:smartcare/features/cart/data/model/remove_item_cart_model.dart';
import 'package:smartcare/features/cart/data/model/request_add_item_model.dart';
import 'package:smartcare/features/cart/data/model/request_remove_item.dart';
import 'package:smartcare/features/cart/data/model/request_update_item_model.dart';
import 'package:smartcare/features/cart/data/model/update_cart_item_model/update_cart_item_model.dart';

class Cartrepo {
  final ApiConsumer apiConsumer;

  Cartrepo({required this.apiConsumer});

  Future<Either<Failure, CreateCartModel>> createcart() async {
    try {
      final response = await apiConsumer.post("api/cart/create", {}, false);
      print("🟡 cart/create RAW => $response");
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = CreateCartModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, AddItemCartModel>> AddItem(
    RequestAddItemModel requestadd,
  ) async {
    try {
      final response = await apiConsumer.post(
        "api/cart/add-item",
        requestadd.toJson(),
        false,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = AddItemCartModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      final serverMessage =
          e.response?.data?['message'] ?? "Something went wrong";
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, RemoveItemCartModel>> RemoveItem(
    RequestRemoveItem requestremove,
  ) async {
    try {
      final response = await apiConsumer.delete(
        "api/cart/remove-item",
        requestremove.toJson(),
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = RemoveItemCartModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, UpdateCartItemModel>> UpdateItemCart(
    RequestUpdateItemModel request,
  ) async {
    try {
      final response = await apiConsumer.put(
        "api/cart/update-item",
        request.toJson(),
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = UpdateCartItemModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, ItemsCart>> GetItemCart(String Cartid) async {
    try {
      final response = await apiConsumer.get("api/cart/${Cartid}/items", null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = ItemsCart.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }
}
