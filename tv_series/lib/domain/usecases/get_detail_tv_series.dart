import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class GetDetailTvSeries {
  final TvSeriesRepository repository;

  GetDetailTvSeries(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getDetail(id);
  }
}
