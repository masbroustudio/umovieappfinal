import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('Save Wathclist Tv Series to the repository', () async {
    when(
      mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail),
    ).thenAnswer(
      (_) async => const Right('Add to Movie Watchlist'),
    );

    final result = await usecase.execute(tTvSeriesDetail);

    verify(
      mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail),
    );
    expect(
      result,
      const Right('Add to Movie Watchlist'),
    );
  });
}
