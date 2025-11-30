import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';

abstract class AddressesRepository {
  Future<Either<servivefailure, List<AddressModel>>> getAddresses();
  Future<Either<servivefailure, AddressModel>> addAddress(AddressModel address);
  Future<Either<servivefailure, bool>> removeAddress(String addressId);
  Future<Either<servivefailure, bool>> setPrimary(String addressId);
}
