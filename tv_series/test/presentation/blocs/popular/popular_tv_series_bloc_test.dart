import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/blocs/popular/popular_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('init state Popular Tv Series should be empty', () {
    expect(
      popularTvSeriesBloc.state,
      PopularTvSeriesEmpty(),
    );
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Emit Loading has Data when data is success',
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right(tTvSeriesList),
      );
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(
      FetchPopularTvSeries(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(
      mockGetPopularTvSeries.execute(),
    ),
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Emit Loading Error when get popular tv series is failed',
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(
      FetchPopularTvSeries(),
    ),
    expect: () => [
      PopularTvSeriesLoading(),
      const PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(
      mockGetPopularTvSeries.execute(),
    ),
  );
}
