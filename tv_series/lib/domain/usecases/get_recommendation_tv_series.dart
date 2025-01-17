import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationTvSeries {
  final TvSeriesRepository repository;

  GetRecommendationTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getRecommendation(id);
  }
}
