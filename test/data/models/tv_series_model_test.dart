import 'package:flutter_test/flutter_test.dart';
import 'package:umovieapp/data/models/tv_series_model.dart';
import 'package:umovieapp/domain/entities/tv_series.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
    posterPath: 'posterPath',
    popularity: 2.3,
  );

  final tTvSeries = TvSeries(
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
    posterPath: 'posterPath',
    popularity: 2.3,
  );

  test('Should be a subclass of TV Series entity', () {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
