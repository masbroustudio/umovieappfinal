import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTvSeries])
void main() {
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetDetailTvSeries mockGetDetailTvSeries;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    detailTvSeriesBloc = DetailTvSeriesBloc(mockGetDetailTvSeries);
  });

  const tId = 1;

  test('init state Detail Tv Series should be empty', () {
    expect(
      detailTvSeriesBloc.state,
      DetailTvSeriesEmpty(),
    );
  });

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'Emit Loading hasData when data is success',
    build: () {
      when(
        mockGetDetailTvSeries.execute(tId),
      ).thenAnswer(
        (_) async => const Right(tTvSeriesDetail),
      );
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(
      const FetchDetailTvSeries(tId),
    ),
    expect: () => [
      DetailTvSeriesLoading(),
      const DetailTvSeriesHasData(tTvSeriesDetail),
    ],
    verify: (bloc) => verify(
      mockGetDetailTvSeries.execute(tId),
    ),
  );

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'Emit Loading Error when get detail tv series is failed',
    build: () {
      when(mockGetDetailTvSeries.execute(tId)).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTvSeries(tId)),
    expect: () => [
      DetailTvSeriesLoading(),
      const DetailTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(
      mockGetDetailTvSeries.execute(tId),
    ),
  );

  group('DetailTvSeriesEvent', () {
    test('supports value comparisons', () {
      expect(
        const FetchDetailTvSeries(1),
        const FetchDetailTvSeries(1),
      );
      expect(
        const FetchDetailTvSeries(1),
        isNot(const FetchDetailTvSeries(2)),
      );
    });

    test('props are correct for FetchDetailTvSeries', () {
      expect(
        const FetchDetailTvSeries(1).props,
        [1],
      );
    });

    test('toString is correct for FetchDetailTvSeries', () {
      expect(
        const FetchDetailTvSeries(1).toString(),
        'FetchDetailTvSeries(1)',
      );
    });
  });
}
