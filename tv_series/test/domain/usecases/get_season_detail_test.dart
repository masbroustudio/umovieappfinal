import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_season_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetSeasonDetail usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetSeasonDetail(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('GET Season Detail Tv Series from the repository', () async {
    when(
      mockTvSeriesRepository.getSeasonDetail(tId, tSeasonNumber),
    ).thenAnswer(
      (_) async => const Right(tSeasonDetail),
    );

    final result = await usecase.execute(tId, tSeasonNumber);

    expect(
      result,
      const Right(tSeasonDetail),
    );
  });
}
