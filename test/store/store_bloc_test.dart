import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartcare/features/stores/data/repositories/store_repository_impl.dart';

import 'mock_api_consumer.dart';

void main() {
  late MockApiConsumer api;
  late StoreRepositoryImpl repo;

  setUp(() {
    api = MockApiConsumer();
    repo = StoreRepositoryImpl(api);
  });

  group('StoreRepository', () {
    test('getStores returns data successfully', () async {
      when(() => api.get(any(), any())).thenAnswer((_) async => {
            "data": [
              {
                "id": "1",
                "name": "Store 1",
                "address": "Cairo",
                "latitude": 30.0,
                "longitude": 31.0,
                "phone": "123"
              }
            ]
          });

      final result = await repo.getStores();

      expect(result.isRight(), true);
    });

    test('getStores returns failure on error', () async {
      when(() => api.get(any(), any())).thenThrow(Exception());

      final result = await repo.getStores();

      expect(result.isLeft(), true);
    });

    test('getNearestStore returns store', () async {
      when(() => api.get(any(), any())).thenAnswer((_) async => {
            "data": [
              {
                "id": "1",
                "name": "Nearest",
                "address": "Cairo",
                "latitude": 30,
                "longitude": 31,
                "phone": "123"
              }
            ]
          });

      final result = await repo.getNearestStore(
        latitude: 30,
        longitude: 31,
      );

      expect(result.isRight(), true);
    });
  });
}