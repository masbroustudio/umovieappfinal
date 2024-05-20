import 'package:core/data/models/tv_series_table.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  const tTvSeriesJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  const tTvSeriesWatchlist = TvSeries.watchlist(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  test('To json should be a subclass of TvSeriesTable', () async {
    final result = tTvSeriesTable.toJson();
    expect(result, tTvSeriesJson);
  });

  test('To entity should be a subclass of TvSeriesTable', () async {
    final result = tTvSeriesTable.toEntity();
    expect(result, tTvSeriesWatchlist);
  });
}
