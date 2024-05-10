import 'package:dartz/dartz.dart';
import 'package:umovieapp/common/failure.dart';
import 'package:umovieapp/domain/entities/tv_series_detail.dart';
import 'package:umovieapp/domain/repositories/tv_series_repository.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlist(tvSeries);
  }
}
