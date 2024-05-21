import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetNowPlayingTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('GET Now Playing Tv Series List from the repository', () async {
    when(
      mockTvSeriesRepository.getNowPlaying(),
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
