import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/profile/data/Model/semantic_model/semantic_model.dart';
import 'package:smartcare/features/profile/data/Model/simillar_search/simillar_search.dart';

class SemanticSearchRepositoy {
  final DioConsumer api;

  SemanticSearchRepositoy({required this.api});

  Future<Either<Failure, SemanticModel>> getitem(String query) async {
    try {
      final response = await api.get(
        "api/Products/search?query=${query.trim()}",
        null,
      );
      final items = SemanticModel.fromJson(response);
      return Right(items);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, SimillarSearchModel>> getsimillaritem(
    String id,
  ) async {
    try {
      final response = await api.get(
        "api/Products/Similars/$id",
        null,
      );
      final items = SimillarSearchModel.fromJson(response);
      return Right(items);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }
}
