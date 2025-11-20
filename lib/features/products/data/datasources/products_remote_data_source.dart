import 'package:smartcare/core/api/api_consumer.dart';

class ProductsRemoteDataSource {
  final ApiConsumer consumer;
  ProductsRemoteDataSource(this.consumer);

  /// Helper to safely cast API responses to Map<String, dynamic>
  Map<String, dynamic> _safeMap(dynamic res) {
    if (res is Map<String, dynamic>) return res;
    print('⚠️ Unexpected response format: $res');
    return {};
  }

  Future<Map<String, dynamic>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {'pageNumber': pageNumber, 'pageSize': pageSize};
    final res = await consumer.get('/api/Products', query);
    return _safeMap(res);
  }

  Future<Map<String, dynamic>> getProductsByCompanyId({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      'CompanyId': companyId,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    final res = await consumer.get('/api/Products/CompanyId', query);
    return _safeMap(res);
  }

  Future<List<dynamic>> getProductsByCategoryId({
    required String categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      'CategoryId': categoryId,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    final response = await consumer.get('/api/Products/CategoryId', query);

    if (response is Map && response.containsKey('data')) {
      final items = response['data']['items'];
      if (items is List) return items;
    }
    return [];
  }

  Future<Map<String, dynamic>> filterProducts({
    bool? orderByName,
    bool? orderByPrice,
    bool? orderByRate,
    double? fromRate,
    double? toRate,
    double? fromPrice,
    double? toPrice,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      if (orderByName != null) 'OrderByName': orderByName,
      if (orderByPrice != null) 'OrderByPrice': orderByPrice,
      if (orderByRate != null) 'OrderByRate': orderByRate,
      if (fromRate != null) 'FromRate': fromRate,
      if (toRate != null) 'ToRate': toRate,
      if (fromPrice != null) 'FromPrice': fromPrice,
      if (toPrice != null) 'ToPrice': toPrice,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    final res = await consumer.get('/api/Products/Filter', query);
    return _safeMap(res);
  }

  Future<Map<String, dynamic>> getProductsByName({
    required String name,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      'NameEn': name,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    final res = await consumer.get('/api/Products/Name', query);
    return _safeMap(res);
  }

  Future<Map<String, dynamic>> getProductsByCompanyName({
    required String companyName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      'CompanyName': companyName,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    final res = await consumer.get('/api/Products/CompanyName', query);
    return _safeMap(res);
  }

  Future<Map<String, dynamic>> getProductsByCategoryName({
    required String categoryName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      'CategoryName': categoryName,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    final res = await consumer.get('/api/Products/CategoryName', query);
    return _safeMap(res);
  }

  Future<Map<String, dynamic>> getProductsByDescription({
    required String description,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final query = {
      'Description': description,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    final res = await consumer.get('/api/Products/Description', query);
    return _safeMap(res);
  }
}
