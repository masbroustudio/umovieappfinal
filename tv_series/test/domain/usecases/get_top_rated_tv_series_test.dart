import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTopRatedTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('GET Top Rated Tv Series from the repository', () async {
    when(
      mockTvSeriesRepository.getTopRated(),
    ).thenAnswer(
      (_) async => Right(tTvSeries),
    );

    final result = await usecase.execute();

    expect(
      result,
      Right(tTvSeries),
    );
  });
}
