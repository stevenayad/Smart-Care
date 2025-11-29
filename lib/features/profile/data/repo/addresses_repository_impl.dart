import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';
import 'addresses_repository.dart';

class AddressesRepositoryImpl implements AddressesRepository {
  final ApiConsumer api;

  AddressesRepositoryImpl(this.api);

  @override
  Future<Either<servivefailure, List<AddressModel>>> getAddresses() async {
    try {
      final response = await api.get("/api/Client/addresses", null);

      List<AddressModel> list =
          (response['data'] as List).map((e) => AddressModel.fromJson(e)).toList();

      return Right(list);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    }
  }

  @override
  Future<Either<servivefailure, AddressModel>> addAddress(AddressModel address) async {
    try {
      final body = {
        "address": address.address,
        "label": address.label,
        "additionalInfo": address.additionalInfo,
        "latitude": address.latitude,
        "longitude": address.longitude,
        "isPrimary": address.isPrimary
      };

      final response = await api.post("/api/Client/addresses/Add", body, false);

      return Right(AddressModel.fromJson(response["data"]));
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    }
  }

  @override
  Future<Either<servivefailure, bool>> removeAddress(String addressId) async {
    try {
      final response =
          await api.delete("/api/Client/addresses/Remove/$addressId", null);

      return Right(response["data"] == true);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    }
  }
}
