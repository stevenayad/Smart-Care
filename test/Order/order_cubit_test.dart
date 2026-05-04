import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/order/data/model/create_order_model/create_order_model.dart';
import 'package:smartcare/features/order/data/model/create_order_model/data.dart';
import 'package:smartcare/features/order/data/model/request_createoreder.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';

class MockOrderRepo extends Mock implements Orderrepo {}

void main() {
  late OrderCubit cubit;
  late MockOrderRepo mockRepo;

  setUp(() {
    mockRepo = MockOrderRepo();
    cubit = OrderCubit(mockRepo);
  });
  setUpAll(() {
    registerFallbackValue(
      RequestCreateoreder(cartId: '', deliveryAddressId: ''),
    );
  });
  final createOrderModel = CreateOrderModel(data: Data(id: "123"));

  blocTest<OrderCubit, OrderState>(
    " create delivery order success",
    build: () {
      when(
        () => mockRepo.createorder(any()),
      ).thenAnswer((_) async => Right(createOrderModel));
      return cubit;
    },
    act: (cubit) => cubit.createDeliveryOrder(cartId: "1", addressId: "2"),
    expect: () => [
      isA<OrderLoading>(),
      isA<CreateorderSucess>(),
      isA<OrderHasActive>(),
    ],
  );

  blocTest<OrderCubit, OrderState>(
    " create order failure",
    build: () {
      when(
        () => mockRepo.createorder(any()),
      ).thenAnswer((_) async => Left(servivefailure("fail")));
      return cubit;
    },
    act: (cubit) => cubit.createDeliveryOrder(cartId: "1", addressId: "2"),
    expect: () => [isA<OrderLoading>(), isA<OrderFailure>()],
  );
}
