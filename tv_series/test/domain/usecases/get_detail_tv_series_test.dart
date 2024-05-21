import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetDetailTvSeries(mockTvSeriesRepository);
  });

  const tId = 1;

  test('GET Tv Series detail from the repository', () async {
    when(
      mockTvSeriesRepository.getDetail(tId),
    ).thenAnswer(
      (_) async => const Right(tTvSeriesDetail),
    );

    final result = await usecase.execute(tId);

    expect(
      result,
      const Right(tTvSeriesDetail),
    );
  });
}
