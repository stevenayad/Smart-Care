import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/order/data/model/address_model/address_model.dart';
import 'package:smartcare/features/order/data/model/address_model/datum.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';

class MockOrderRepo extends Mock implements Orderrepo {}

void main() {
  late AddressStoreCubit cubit;
  late MockOrderRepo mockRepo;

  setUp(() {
    mockRepo = MockOrderRepo();
    cubit = AddressStoreCubit(mockRepo);
  });

  final addressModel = AddressModel(
    data: [
      AddressDatum(
        id: "1",
        address: "Nasr City",
      ),
    ],
  );

  blocTest<AddressStoreCubit, AddressStoreState>(
    " get address success",
    build: () {
      when(() => mockRepo.getaddress())
          .thenAnswer((_) async => Right(addressModel));
      return cubit;
    },
    act: (cubit) => cubit.getaddress(),
    expect: () => [
      const AddressStoreState(isAddressLoading: true),
      isA<AddressStoreState>()
          .having((s) => s.isAddressLoading, "loading", false)
          .having((s) => s.addresses.length, "data", 1),
    ],
  );

  blocTest<AddressStoreCubit, AddressStoreState>(
    " get address failure",
    build: () {
      when(() => mockRepo.getaddress())
          .thenAnswer((_) async => Left(servivefailure("error")));
      return cubit;
    },
    act: (cubit) => cubit.getaddress(),
    expect: () => [
      const AddressStoreState(isAddressLoading: true),
      isA<AddressStoreState>()
          .having((s) => s.addressError, "error", "error"),
    ],
  );
}