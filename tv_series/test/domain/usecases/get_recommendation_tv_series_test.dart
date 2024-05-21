import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetRecommendationTvSeries(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  test('GET Recommendations Tv Series from the repository', () async {
    when(mockTvSeriesRepository.getRecommendation(tId)).thenAnswer(
      (_) async => Right(tTvSeries),
    );

    final result = await usecase.execute(tId);

    expect(
      result,
      Right(tTvSeries),
    );
  });
}
