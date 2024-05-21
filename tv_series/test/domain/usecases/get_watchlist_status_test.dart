import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListStatusTvSeries(mockTvSeriesRepository);
  });

  const tId = 1;

  test('GET Watchlist Status from repository', () async {
    when(
      mockTvSeriesRepository.isAddedToWatchlist(1),
    ).thenAnswer((_) async => true);

    final result = await usecase.execute(tId);

    expect(result, true);
  });
}
