import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetPopularTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('GET Popular Tv Series List from the repository', () async {
    when(
      mockTvSeriesRepository.getPopular(),
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
