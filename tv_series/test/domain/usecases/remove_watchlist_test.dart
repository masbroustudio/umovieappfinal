import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('Remove Watchlist Tv Series from repository', () async {
    when(
      mockTvSeriesRepository.removeWatchlist(tTvSeriesDetail),
    ).thenAnswer(
      (_) async => const Right('Remove from Movie Watchlist'),
    );

    final result = await usecase.execute(tTvSeriesDetail);

    verify(
      mockTvSeriesRepository.removeWatchlist(tTvSeriesDetail),
    );

    expect(
      result,
      const Right('Remove from Movie Watchlist'),
    );
  });
}
