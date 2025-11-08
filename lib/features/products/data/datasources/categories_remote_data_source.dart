import 'package:smartcare/core/api/api_consumer.dart';

class CategoriesRemoteDataSource {
  final ApiConsumer consumer;
  CategoriesRemoteDataSource(this.consumer);

  Future<List<dynamic>> getCategories() async {
    final res = await consumer.get('/api/categories', null);
    if (res is Map && res.containsKey('data')) {
      return res['data'] as List<dynamic>;
    }
    return [];
  }
}
