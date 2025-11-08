import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/features/stores/data/models/store_model.dart';

abstract class StoreRemoteDataSource {
  Future<StoreModel> fetchStores();
}

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final ApiConsumer apiConsumer;

  StoreRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<StoreModel> fetchStores() async {
    final response = await apiConsumer.get('/api/Stores', null);
    return StoreModel.fromJson(response);
  }
}
