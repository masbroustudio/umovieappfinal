import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRated();
  }
}
