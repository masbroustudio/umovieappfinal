import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:tv_series/domain/usecases/search_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];
  const tQuery = 'Greek';

  test('GET Search Tv Series from the repository', () async {
    when(
      mockTvSeriesRepository.search(tQuery),
    ).thenAnswer(
      (_) async => Right(tTvSeries),
    );

    final result = await usecase.execute(tQuery);

    expect(
      result,
      Right(tTvSeries),
    );
  });
}
