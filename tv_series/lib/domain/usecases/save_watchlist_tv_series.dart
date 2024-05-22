import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
