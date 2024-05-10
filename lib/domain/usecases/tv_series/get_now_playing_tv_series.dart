import 'package:dartz/dartz.dart';
import 'package:umovieapp/common/failure.dart';
import 'package:umovieapp/domain/entities/tv_series.dart';
import 'package:umovieapp/domain/repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}
