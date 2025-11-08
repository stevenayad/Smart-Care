import 'package:smartcare/core/api/api_consumer.dart';

class CategoriesRemoteDataSource {
  final ApiConsumer consumer;
  CategoriesRemoteDataSource(this.consumer);

  Future<List<dynamic>> getCategories() async {
    final res = await consumer.get('/api/categories', null);

    if (res is Map && res.containsKey('data')) {
      final data = res['data'];
      if (data is List) return data;
      if (data is Map && data.containsKey('items') && data['items'] is List) {
        return data['items'] as List;
      }
    }

    print('⚠️ Unexpected categories response format: $res');
    return [];
  }
}
