import 'package:smartcare/core/api/api_consumer.dart';

class CompaniesRemoteDataSource {
  final ApiConsumer consumer;
  CompaniesRemoteDataSource(this.consumer);

  Future<List<dynamic>> getCompanies() async {
    final res = await consumer.get('/api/companies', null);

    if (res is Map && res.containsKey('data')) {
      final data = res['data'];
      if (data is List) return data;
      if (data is Map && data.containsKey('items') && data['items'] is List) {
        return data['items'] as List;
      }
    }

    print('⚠️ Unexpected companies response format: $res');
    return [];
  }
}
