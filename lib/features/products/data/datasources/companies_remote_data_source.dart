import 'package:smartcare/core/api/api_consumer.dart';

class CompaniesRemoteDataSource {
  final ApiConsumer consumer;
  CompaniesRemoteDataSource(this.consumer);

  Future<List<dynamic>> getCompanies() async {
    final res = await consumer.get('/api/companies', null);
    if (res is Map && res.containsKey('data')) {
      return res['data'] as List<dynamic>;
    }
    return [];
  }
}
