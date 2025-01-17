import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlaying();
  Future<Either<Failure, List<TvSeries>>> getTopRated();
  Future<Either<Failure, List<TvSeries>>> getPopular();
  Future<Either<Failure, TvSeriesDetail>> getDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getRecommendation(int id);
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
    int id,
    int seasonNumber,
  );
  Future<Either<Failure, List<TvSeries>>> getWatchlist();
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeriesDetail);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, String>> removeWatchlist(
    TvSeriesDetail tvSeriesDetail,
  );
  Future<Either<Failure, List<TvSeries>>> search(String query);
}
