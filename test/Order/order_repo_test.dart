import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/order/data/model/store_model/store_model.dart';
import 'package:smartcare/features/order/data/repo/order_repo_implementation.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';

class MockApiConsumer extends Mock implements ApiConsumer {}

void main() {
  late Orderrepo repo;
  late MockApiConsumer mockApi;

  setUp(() {
    mockApi = MockApiConsumer();
    repo = OrderRepoImplementation(apiConsumer: mockApi);
  });

  group("getStore", () {
    test(" success", () async {
      final fakeResponse = {
        "statusCode": 200,
        "succeeded": true,
        "data": [
          {
            "id": "1",
            "name": "Pharmacy 1",
            "address": "Cairo",
            "latitude": 30.0,
            "longitude": 31.0,
            "phone": "01000000000",
          },
        ],
      };

      when(
        () => mockApi.get(any(), any()),
      ).thenAnswer((_) async => fakeResponse);

      final result = await repo.getstore();

      expect(result.isRight(), true);

      result.fold((_) => fail("should not fail"), (data) {
        expect(data.data!.isNotEmpty, true);
        expect(data.data!.first.name, "Pharmacy 1");
      });
    });

    test(" invalid response", () async {
      when(() => mockApi.get(any(), any())).thenAnswer((_) async => null);

      final result = await repo.getstore();

      expect(result, isA<Left<Failure, StoreOrderModel>>());
    });
  });
}
